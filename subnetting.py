import math

def dec_to_bin(n):
    b = bin(n)[2:]
    output = b.rjust(8,'0')
    return [int(i) for i in output]

def bin_to_dec(num):
    num = [str(i) for i in num]
    b = ''.join(num)
    return int(b,2)

def cidr_subnet_generation(cidr_number):
    subnet = '1'*cidr_number
    output = subnet.ljust(32,'0')
    return [int(i) for i in output]

def boolean_and(num1 , num2):
    ans = []
    for i in range(len(num1)):
        ans.append(int(num1[i] == 1 and num2[i] == 1))
    return ans

def ip_decimal_generation(ip_address):
    ans = ""
    for i in range(0,len(ip_address),8):
        ans += str(bin_to_dec(ip_address[i : i+8])) + '.'
    return ans

def ip_octet_generation(ip_address):
    ans = []
    for i in range(0,len(ip_address),8):
        ans.append(bin_to_dec(ip_address[i : i + 8]))
    return ans

def ip_address_generation(starting_ip_octets , n):
    c0 = starting_ip_octets[3]
    c1 = starting_ip_octets[2]
    c2 = starting_ip_octets[1]
    c3 = starting_ip_octets[0]

    i=0
    addresses = []

    for c3 in range(starting_ip_octets[0] , 256):
        for c2 in range(starting_ip_octets[1] , 256):
            for c1 in range(starting_ip_octets[2] , 256):
                for c0 in range(starting_ip_octets[3] , 256):
                    if i>=n:
                        break
                    addresses.append((c3 , c2 , c1 , c0))
                    i += 1

    return addresses


input_ip_str = input("Enter an IPv4 address: ")#192.168.4.0
octets = list(map(int,input_ip_str.split(".")))

ip_bin = []
ip_class = ""

for octet in octets:
    ip_bin += dec_to_bin(octet)

if octets[0] >= 0 and octets[0] <= 127:
    ip_class = "A"
    print("Class of given IP: Class A")
    print("Default Subnet Mask: 255.0.0.0")
elif octets[0] >= 128 and octets[0] <= 191:
    ip_class = "B"
    print("Class of given IP: Class B")
    print("Default Subnet Mask: 255.255.0.0")
elif octets[0] >= 192 and octets[0] <= 223:
    ip_class = "C"
    print("Class of given IP: Class C")
    print("Default Subnet Mask: 255.255.255.0")
elif octets[0] >= 224 and octets[0] <= 239:
    print("Class of given IP: Class D")
elif octets[0] >= 240 and octets[0] <= 254:
    print("Class of given IP: Class E")


print("Choices: 1. CIDR Number(ex. 27) , 2. Number of subnets(ex. 8)")
choice = int(input("Enter the choice: "))

if choice == 1:
    cidr_num = int(input("Enter the CIDR Number: "))
    subnet_mask = cidr_subnet_generation(cidr_num)
    result = boolean_and(ip_bin,subnet_mask)
    num_hosts = 2**(32-cidr_num)

    print("Number of hosts available: " , num_hosts)
    print("Subnet mask: ", ip_decimal_generation(subnet_mask) , "/" , cidr_num)
    print("Starting address of subnet: " , ip_decimal_generation(result))
    results_octets = ip_octet_generation(result)
    ip_addresses = ip_address_generation(results_octets , num_hosts)
    print("Network address: " , ip_addresses[0])
    print("Broadcast address: " , ip_addresses[-1])

elif choice == 2:
    num_subnets = int(input("Enter the number of subnets: "))
    num_hosts_per_class = {
        "A": 256 * 256 * 256,
        "B": 256 * 256,
        "C": 256   
    }
    num_hosts_per_subnet = num_hosts_per_class[ip_class]
    num_host_bits = int(math.log2(num_hosts_per_subnet))
    num_network_bits = 32 - num_host_bits
    subnet_mask = cidr_subnet_generation(num_network_bits)
    print("Maximum hots possible in this IP class: " , num_hosts_per_class)
    print("Number of hosts per subnet (all): ", num_hosts_per_subnet)
    print("Number of usable hosts: " , num_hosts_per_subnet - 2)
    print("Subnet Mask Required: ",ip_decimal_generation(subnet_mask) , "/" , num_network_bits)