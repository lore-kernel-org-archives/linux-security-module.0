From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Wed, 11 Jul 2018 09:38:15 +0200
Subject: [PATCH RFC] Smack: Fix handling of IPv4 traffic received by
	PF_INET6 sockets
In-Reply-To: <38c70a10-b68e-358f-a1cf-9e2221747e7e@schaufler-ca.com>
References: <CGME20180710070515eucas1p1dddc12cc44c820971809a242e8cee106@eucas1p1.samsung.com>
	<20180710070515eucas1p1dddc12cc44c820971809a242e8cee106~-8AfqiO9s0149301493eucas1p1h@eucas1p1.samsung.com>
	<7e7b9c3e-1fa4-d0fa-fbba-10493af52c4d@schaufler-ca.com>
	<20180710154423eucas1p226cf025ee545e16929eede4d419eca7c~ADFw04F9H1188711887eucas1p2n@eucas1p2.samsung.com>
	<38c70a10-b68e-358f-a1cf-9e2221747e7e@schaufler-ca.com>
Message-ID: <20180711073817eucas1p1590871dcbd2ae88c466f7558602366dc~AQGoFdvsr1461214612eucas1p1C@eucas1p1.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 07/10/2018 06:16 PM, Casey Schaufler wrote:
> On 7/10/2018 8:44 AM, Piotr Sawicki wrote:
>> On 07/10/2018 05:21 PM, Casey Schaufler wrote:
>>> On 7/10/2018 12:05 AM, Piotr Sawicki wrote:
>>>> A socket which has sk_family set to PF_INET6 is able to receive not
>>>> only IPv6 but also IPv4 traffic (IPv4-mapped IPv6 addresses).
>>>>
>>>> Prior to this patch, the smk_skb_to_addr_ipv6() could have been
>>>> called for socket buffers containing IPv4 packets, in result such
>>>> traffic was allowed.
>>>>
>>>> Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
>>> Looks fine from here. Do you have a simple test case?
>>
>> Yes, I've tested it on Tizen emulator.
>>
>> Tests are available here
>> https://review.tizen.org/gerrit/#/admin/projects/platform/core/test/security-tests,
>> branch nether.
> 
> Can you identify the specific test? There's quite a bit to look through.
> Thank you.

ID:NETHER_IPV6_IPV4_LOCAL_INTER_APP_CONNECTION:nether_check_ipv6_srv_ipv4_udp_local_inter_app_connection_internet_access_granted
ID:NETHER_IPV6_IPV4_LOCAL_INTER_APP_CONNECTION:nether_check_ipv6_srv_ipv4_udp_local_inter_app_connection_internet_access_denied

It's a new thing, so tests are still in review: 
https://review.tizen.org/gerrit/#/c/183458/

To run the tests on the emulator you need to apply also these patches:
(Nether) https://review.tizen.org/gerrit/#/c/183464/ and turn on IPv6 
connection tracking in the kernel. I've used a kernel downloaded from 
https://review.tizen.org/gerrit/#/admin/projects/sdk/emulator/emulator-kernel 
branch tizen.

I know that these tests are Tizen specific, and it might be really time 
consuming to prepare an environment for them. So, I propose to just use 
the netcat tool and run one of its instances as a UDP server listening 
on IPv6 address [::] and the second one as a IPV4 client.

e.g.
server: nc -6 -l -u 20000
client: nc -u 127.0.0.1 20000

In case of TCP connections, access is properly checked in 
smack_inet_conn_request(). But when IPv4-mapped IPv6 addresses are used 
and two processes have write access to each other, 
smack_socket_sock_rcv_skb() will call smk_skb_to_addr_ipv6() function 
for IPv4 packets.





--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
