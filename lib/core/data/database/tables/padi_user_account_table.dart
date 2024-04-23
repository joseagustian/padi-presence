class PadiUserAccountTable {

  final String name = 'padi_user_account';
  final String schema =
  '''
  user_id TEXT PRIMARY KEY, 
  user_email TEXT, 
  user_account_name TEXT, 
  user_employee_id TEXT, 
  user_date_of_birth TEXT, 
  user_address TEXT, 
  user_religion TEXT, 
  user_job_position TEXT, 
  user_job_division TEXT,
  user_access_token TEXT,
  user_office_lat TEXT,
  user_office_long TEXT,
  on_progress_attendance_id TEXT
  ''';

}