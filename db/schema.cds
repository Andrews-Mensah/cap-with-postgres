namespace cap_app_pg;

using {
    cuid,
    managed
} from '@sap/cds/common';

type Stream : String enum {
    Electrical      = 'EEE';
    Electronics     = 'ECE';
    ComputerScience = 'CE';
};

entity Student : cuid, managed {
    studentID  : Integer;
    first_name : String(20);
    last_name  : String(20);
    dob        : Date;
    email      : String;
    stream     : Stream;
}