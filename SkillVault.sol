// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SkillVault {
    address public admin;
    uint public skillCount = 0;

    struct Skill {
        string name;
        address earner;
        address issuer;
        uint timestamp;
        uint endorsements;
    }

    mapping(uint => Skill) private skills;
    mapping(address => uint[]) public userSkills;
    mapping(address => bool) public approvedIssuers;
    mapping(uint => mapping(address => bool)) public hasEndorsed; // moved from inside struct

    event SkillIssued(uint skillId, address earner, string name);
    event SkillEndorsed(uint skillId, address endorser);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    modifier onlyIssuer() {
        require(approvedIssuers[msg.sender], "Not an approved issuer");
        _;
    }

    constructor() {
        admin = msg.sender;
        approvedIssuers[msg.sender] = true; // admin is a default issuer
    }

    function addIssuer(address _issuer) external onlyAdmin {
        approvedIssuers[_issuer] = true;
    }

    function removeIssuer(address _issuer) external onlyAdmin {
        approvedIssuers[_issuer] = false;
    }

    function issueSkill(address _to, string memory _name) external onlyIssuer {
        skillCount++;
        Skill storage s = skills[skillCount];
        s.name = _name;
        s.earner = _to;
        s.issuer = msg.sender;
        s.timestamp = block.timestamp;
        s.endorsements = 0;
        userSkills[_to].push(skillCount);

        emit SkillIssued(skillCount, _to, _name);
    }

    function endorseSkill(uint _skillId) external {
        require(_skillId > 0 && _skillId <= skillCount, "Invalid skill ID");
        Skill storage s = skills[_skillId];
        require(msg.sender != s.earner, "You cannot endorse yourself");
        require(!hasEndorsed[_skillId][msg.sender], "You already endorsed this skill");

        hasEndorsed[_skillId][msg.sender] = true;
        s.endorsements++;

        emit SkillEndorsed(_skillId, msg.sender);
    }

    function getSkill(uint _skillId) public view returns (
        string memory name,
        address earner,
        address issuer,
        uint timestamp,
        uint endorsements
    ) {
        Skill storage s = skills[_skillId];
        return (s.name, s.earner, s.issuer, s.timestamp, s.endorsements);
    }

    function getSkillsOfUser(address _user) external view returns (uint[] memory) {
        return userSkills[_user];
    }
}
