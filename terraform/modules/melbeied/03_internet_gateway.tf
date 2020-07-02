## Internet geteway : creation
resource "aws_internet_gateway" "igt" {
  vpc_id = aws_vpc.melbeied.id
  tags  = {
    Name = "main_igw"
  }
 }

 
// Exemple : terraform.io
//  resource "aws_internet_gateway" "gw" {
//   vpc_id = "${aws_vpc.main.id}"
// }

// resource "aws_instance" "foo" {
//   # ... other arguments ...

//   depends_on = ["aws_internet_gateway.gw"]
// }