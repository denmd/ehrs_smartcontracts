// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract AccessControl {
    address public owner;

    struct Doctor {
        bool hasAccess;
    }

    mapping(address => Doctor) public doctors;
    mapping(address => bool) public patients;

    event AccessGranted(address patient, address doctor);
    event AccessRevoked(address patient, address doctor);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyPatient() {
        require(patients[msg.sender], "Only patients can call this function");
        _;
    }

    modifier onlyDoctor() {
        require(doctors[msg.sender].hasAccess, "Only doctors with access can call this function");
        _;
    }

    function grantAccess(address _doctor) public onlyPatient {
        doctors[_doctor] = Doctor(true);
        emit AccessGranted(msg.sender, _doctor);
    }

    function revokeAccess(address _doctor) public onlyPatient {
        delete doctors[_doctor];
        emit AccessRevoked(msg.sender, _doctor);
    }
}
