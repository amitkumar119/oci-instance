
provider "oci" {
   region = "us-ashburn-1"
   //alias = "phx"
   tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaauuao4pnrffvzgxylvbobagcyo35qsu6z4bqdvjcla4czevhriqvq"
   user_ocid = "ocid1.user.oc1..aaaaaaaawimuaayeafktaqctwt4twmobbka5awtsepkd4rvss4mtvykxg3pa"
   fingerprint = "9c:ed:78:5d:da:35:17:05:0a:6b:93:be:b0:84:38:5c"
   private_key_path = "./amitTestPrivate.pem"
}


resource "oci_core_instance" "testhostAmit" {
  # Required
  count = 1
  availability_domain = "ubQd:US-ASHBURN-AD-2"
  // For Compartment = AmitChildCompartment 
  //compartment_id      = "ocid1.compartment.oc1..aaaaaaaaywbpujwoxt7wpxvxawpv2xneun36ccmwk4baal7gpjmsswosmrwq"
  // For Compartment = oci-intelibliss-test
  compartment_id =  "ocid1.compartment.oc1..aaaaaaaammdmuwe7hgei2iu4lar6rtg7o4gmvnp572lfxvgwo5xky4z6ajwa"
  shape               = "VM.Standard.E2.1.Micro"
  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
  }
  source_details {
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagubx53kzend5acdvvayliuna2fs623ytlwalehfte7z2zdq7f6ya"
    source_type = "image"
  }
  # Optional
  display_name = "testhostAmit${count.index}"
  create_vnic_details {
    assign_public_ip = true
    // For AmitChildCompartment
    // subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaa74trcuememyseily3jm5ltzbf7kr4nuv5z3rfaxfiivpln3jeefa"
    //For Intellibliss Public Subnet
    subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaamfuaw2esu2d5tv4n76hzetytv5v2qkf2nospjppjhm42rgntknba"
  }
 # metadata = {
  #ssh_authorized_keys = file(var.ssh_public_key)
    # user_data           = base64encode(file("./bootstrap"))
  #}
  preserve_boot_volume = false
}
