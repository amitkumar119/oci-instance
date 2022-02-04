
/*provider "oci" {
   region = "us-ashburn-1"
   //alias = "phx"
   tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaa4mzf57gl7afpkuhti3rq76gie762ciyfwuvu6xn4tcxndj7zhi3q"
   user_ocid = "ocid1.user.oc1..aaaaaaaazqp7tubplumg7ej2lfcdwwwgifjywwww4ct33ntv3fsixkbtybpa"
   fingerprint = "8e:95:5f:54:c0:f5:28:b3:fe:9b:0b:1f:a8:e7:1e:6b"
   private_key_path = "./amitTestPrivatePartner.pem"
}
*/
   
variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key" {
}

//variable "ssh_public_key" {
//}

//variable "compartment_ocid" {
//}

variable "region" {
}

provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key      = var.private_key
}


resource "oci_core_instance" "testhostAmit" {
  # Required
  count = 1
  availability_domain = "IYfK:US-ASHBURN-AD-1"
  // For Compartment = AmitChildCompartment 
  //compartment_id      = "ocid1.compartment.oc1..aaaaaaaaywbpujwoxt7wpxvxawpv2xneun36ccmwk4baal7gpjmsswosmrwq"
  // For Compartment = oci-intelibliss-test
  // compartment_id =  "ocid1.compartment.oc1..aaaaaaaammdmuwe7hgei2iu4lar6rtg7o4gmvnp572lfxvgwo5xky4z6ajwa"
  // The below compartment is for Partner Tenancy
   compartment_id =  "ocid1.compartment.oc1..aaaaaaaad4r5xrowh7vfojhsifwew473fwruqd5asuppfwzqytoyml6lizda"
  shape               = "VM.Standard.E4.Flex"
  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
  }
  source_details {
    source_id   = "ocid1.image.oc1.iad.aaaaaaaaffh3tppq63kph77k3plaaktuxiu43vnz2y5oefkec37kwh7oomea"
    source_type = "image"
  }
  # Optional
  display_name = "testhostAmitPartner${count.index}"
  create_vnic_details {
    assign_public_ip = true
    // For AmitChildCompartment
    // subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaa74trcuememyseily3jm5ltzbf7kr4nuv5z3rfaxfiivpln3jeefa"
    //For Intellibliss Public Subnet
    //subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaamfuaw2esu2d5tv4n76hzetytv5v2qkf2nospjppjhm42rgntknba"
    //For Partner tenancy Subnet.     
    subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaalmeu2nnplhqmxer74rkyfnpptcazk427fkygv2tk6eyfdc5fiicq"
  }
 # metadata = {
  #ssh_authorized_keys = file(var.ssh_public_key)
    # user_data           = base64encode(file("./bootstrap"))
  #}
  preserve_boot_volume = false
}
