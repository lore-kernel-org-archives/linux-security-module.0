From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 14 Jun 2017 09:39:44 -0700
Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
In-Reply-To: <d6d7dbd5-63f4-7ba3-bda0-dce80d26fb92@partner.sasmung.com>
References: <CGME20170609024301epcas3p42a76d6e0e1c8ef38636c08bd478a9d59@epcas3p4.samsung.com>
	<3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
	<d6d7dbd5-63f4-7ba3-bda0-dce80d26fb92@partner.sasmung.com>
Message-ID: <62ebea58-9c00-88a8-9d53-20b3395c1de7@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/13/2017 11:50 PM, Piotr Sawicki wrote:
> Hi,
>
> My name is Piotr. Currently I'm involved in maintaining the Nether service (a user-space firewall used in Tizen). I have a few remarks about this patch.

Thanks for the review. It is most helpful.

>
> On 06/09/2017 04:41 AM, Casey Schaufler wrote:
>> Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>
>> @@ -4042,15 +4094,19 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>           rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
>>           rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
>>                       MAY_WRITE, rc);
>> -        if (rc != 0)
>> +        if (rc == 0)
>> +            break;
>> +        if (by_host)
>> +            icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
>> +        else
>>               netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
>>           break;
>>   #if IS_ENABLED(CONFIG_IPV6)
>>       case PF_INET6:
>> -        proto = smk_skb_to_addr_ipv6(skb, &sadd);
>> -        if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
>> +        rc = smk_skb_to_addr_ipv6(skb, &sadd);
>> +        if (rc != IPPROTO_UDP && rc != IPPROTO_TCP)
>>               break;
>
> The PF_INET6 socket may receive IPv4 packets too. In this case smk_skb_to_addr_ipv6() returns -EINVAL or some rubbish value. Furthermore, the smk_skb_to_addr_ipv6() function returns a detected protocol type (e.g. DCCP). If it is neither TCP nor UDP, then the packet will be blocked.

Which behavior do you think would be proper? I can't tell if
this is an observation or a complaint.

>
> I wonder why are the other protocols not handled here (e.g. UDP Lite, DCCP)?

No one has asked for it. Patches welcome!

>
>> -#ifdef SMACK_IPV6_SECMARK_LABELING
>> +#ifdef CONFIG_SECURITY_SMACK_NETFILTER
>>           if (skb && skb->secmark != 0)
>>               skp = smack_from_secid(skb->secmark);
>>           else
>> @@ -4066,10 +4122,9 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>           rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
>>           rc = smk_bu_note("IPv6 delivery", skp, ssp->smk_in,
>>                       MAY_WRITE, rc);
>> -#endif /* SMACK_IPV6_SECMARK_LABELING */
>> -#ifdef SMACK_IPV6_PORT_LABELING
>> +#else
>>           rc = smk_ipv6_port_check(sk, &sadd, SMK_RECEIVING);
>> -#endif /* SMACK_IPV6_PORT_LABELING */
>> +#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
>>           break;
>>   #endif /* CONFIG_IPV6 */
>>       }
>> @@ -4149,11 +4204,14 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
>>           s = ssp->smk_out->smk_secid;
>>           break;
>>       case PF_INET:
>> -#ifdef CONFIG_SECURITY_SMACK_NETFILTER
>> +        skp = smack_ipv4_skb_host_label(skb);
>> +        if (skp) {
>> +            s = skp->smk_secid;
>> +            break;
>> +        }
>
> There are three functions which have very similar fragments of code. They deduce a Smack label from an incoming socket buffer. I've noticed some inconsistencies:
> - In the smack_socket_sock_recv_skb() function skp defaults to smack_net_ambient.
> - In smack_socket_getpeersec_dgram() the secid variable defaults to 0, which means the invalid secid.
> - In the smack_inet_conn_request() function the default value is smack_known_huh.
>
> Is it intentional?

I'll have to look and see. As I was working on this I noticed
some inconsistency, and did clean some of it up. Thank you
for the comment.

>
>> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
>> index 205b785..9904f37 100644
>> --- a/security/smack/smack_netfilter.c
>> +++ b/security/smack/smack_netfilter.c
>> @@ -51,7 +51,9 @@ static unsigned int smack_ipv4_output(void *priv,
>>       if (sk && sk->sk_security) {
>>           ssp = sk->sk_security;
>>           skp = ssp->smk_out;
>> -        skb->secmark = skp->smk_secid;
>> +        if (ssp->smk_state == SMK_SOCK_DEFERRED &&
>> +            netlbl_skbuff_setattr(skb, PF_INET, &skp->smk_netlabel))
>> +            return NF_DROP;
>>       }
>>         return NF_ACCEPT;
>
> The above change will affect the NFQUEUE mechanism. The secmark field of a socket buffer is used by the nfqnl_get_sk_secctx() function (net/netfilter/nfnetlink_queue.c) to retrieve a Smack label (a security context). Please take a look at this commit regarding libnetfilter_queue: https://git.netfilter.org/libnetfilter_queue/commit/?id=46912f1c18e01b63660a56ea7d9c572741e06117 The Nether service (https://wiki.tizen.org/Security:Nether) uses libnetfilter_queue to implement a software firewall. It utilizes the security context and UDI/GID fields of a netlink message to make a decision about what to do with an outgoing packet.

I'll put the skb->secmark = skp->smk_secid; back.

>
> Also, I've noticed an inconsistency of handling the secmark field for IPv4 and IPv6 protocols. In smack_ipv6_output function() the skp->smk_secid field is copied to skb->secmark.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
