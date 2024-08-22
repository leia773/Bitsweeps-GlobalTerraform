

variable "region" {

    type = string
    default = "us-west-2"
    description = "majority of the stack will be deployed in this region"

}

variable "bucket_name" {

    type = string
    description = "give a sutiable name for  s3 bucket (terraform backend)"
  
}

variable "table_name" {

    type = string
    description = "give a sutiable name for  dynamodb   (terraform table )"

  
}