From: p.sawicki2@partner.sasmung.com (Piotr Sawicki)
Date: Fri, 16 Jun 2017 13:05:09 +0200
Subject: [SMACK-discuss] [PATCH RFC] Smack: More sanity in the use of
	Netlabel
In-Reply-To: <62ebea58-9c00-88a8-9d53-20b3395c1de7@schaufler-ca.com>
References: <CGME20170609024301epcas3p42a76d6e0e1c8ef38636c08bd478a9d59@epcas3p4.samsung.com>
	<3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
	<d6d7dbd5-63f4-7ba3-bda0-dce80d26fb92@partner.sasmung.com>
	<62ebea58-9c00-88a8-9d53-20b3395c1de7@schaufler-ca.com>
Message-ID: <6d097223-e1d1-1fd9-d77d-3a7cf8bf89a5@partner.sasmung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I'm sorry for the late reply. We had a public holiday yesterday.

On 06/14/2017 06:39 PM, Casey Schaufler wrote:
>>>    #if IS_ENABLED(CONFIG_IPV6)
>>>        case PF_INET6:
>>> -        proto = smk_skb_to_addr_ipv6(skb, &sadd);
>>> -        if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
>>> +        rc = smk_skb_to_addr_ipv6(skb, &sadd);
>>> +        if (rc != IPPROTO_UDP && rc != IPPROTO_TCP)
>>>                break;
>>
>> The PF_INET6 socket may receive IPv4 packets too. In this case smk_skb_to_addr_ipv6() returns -EINVAL or some rubbish value. Furthermore, the smk_skb_to_addr_ipv6() function returns a detected protocol type (e.g. DCCP). If it is neither TCP nor UDP, then the packet will be blocked.
> 
> Which behavior do you think would be proper? I can't tell if
> this is an observation or a complaint.

This is an observation. I've checked it on the Tizen emulator. A SSH 
server running on it uses a listening socket bound to the [::] IPv6 
address (IN6ADDR_ANY_INIT). This socket has also the IPV6_V6ONLY option 
turned off. All this means that, it can accept not only IPv6 but also 
IPv4 connections. When I was trying to make a SSH connection to the 
emulator using its IPv4 address, I noticed that incoming IPv4 packets 
were handled by the section of code intended for handling IPv6 traffic 
(sk->sk_family == PF_INET6). Because the smk_skb_to_addr_ipv6() had not 
been designed for processing IPv4 packets, this function returned some 
garbage values. In result all the SSH traffic was blocked.

I think that this issue would be readily fixed by checking the protocol 
field of an incoming skb, in the same way as the 
selinux_socket_sock_rcv_skb() function does (security/selinux/hooks.c). 
Moreover, smack_socket_sock_rcv_skb() should return 0 (accept) when the 
type of transport layer protocol of an incoming skb is neither TCP nor 
UDP. The other transport protocols, which are not taken into account, 
shouldn't be blocked.

>>
>> I wonder why are the other protocols not handled here (e.g. UDP Lite, DCCP)?
> 
> No one has asked for it. Patches welcome!
> 

OK. I will try to prepare a patch that handles the other kinds of protocols.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
