variable "aws_access_key" {
  description = "AWS APIアクセスキー"
}

variable "aws_secret_key" {
  description = "AWS APIシークレットキー"
}

variable "ssh_private_key_path" {
  description = "秘密鍵ファイルのPath"
}

variable "ssh_public_key_path" {
  description = "公開鍵ファイルのPath"
}

variable "security_group_id" {
  description = "既存セキュリティグループのid"
}

variable "prefix" {
  description = "リソースの名前のPrefix"
  default     = "DevEnv"
}
