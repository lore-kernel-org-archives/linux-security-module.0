From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 17 Jul 2018 08:01:20 -0700
Subject: [PATCH RFC] Smack: Fix handling of IPv4 traffic received by
	PF_INET6 sockets
In-Reply-To: <20180717102832eucas1p2326369ce6b5a27842754df987e5ae82f~CIS-MrwYL0456804568eucas1p2e@eucas1p2.samsung.com>
References: <CGME20180710070515eucas1p1dddc12cc44c820971809a242e8cee106@eucas1p1.samsung.com>
	<20180710070515eucas1p1dddc12cc44c820971809a242e8cee106~-8AfqiO9s0149301493eucas1p1h@eucas1p1.samsung.com>
	<0d419a61-603a-a244-83d0-dbd80cb6ad3a@schaufler-ca.com>
	<20180717102832eucas1p2326369ce6b5a27842754df987e5ae82f~CIS-MrwYL0456804568eucas1p2e@eucas1p2.samsung.com>
Message-ID: <2e368779-7ef2-ba27-326d-8210ca2eb0c8@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 7/17/2018 3:28 AM, Piotr Sawicki wrote:
>
> On 07/17/2018 01:33 AM, Casey Schaufler wrote:
>> On 7/10/2018 12:05 AM, Piotr Sawicki wrote:
>>> A socket which has sk_family set to PF_INET6 is able to receive not
>>> only IPv6 but also IPv4 traffic (IPv4-mapped IPv6 addresses).
>>>
>>> Prior to this patch, the smk_skb_to_addr_ipv6() could have been
>>> called for socket buffers containing IPv4 packets, in result such
>>> traffic was allowed.
>>>
>>> Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com
>>
>> I have added this to git://github.com/cschaufler/next-smack#smack-for-4.19
>> after doing a little whitespace clean-up and removal of unnecessary braces.
> I see that the wrong version of the patch was applied. It should be a 
> version taken from the email titled "[PATCH RFC] Smack: Fix handling of 
> IPv4 traffic received by PF_INET6 sockets" (10th of July 2018). The 
> family variable should be used also in netlbl_skbuff_getattr(), 
> netlbl_skbuff_err and in audit structure.

Please resend the correct version with a "v2". Thank you.

>
>
>>> ---
>>>    security/smack/smack_lsm.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index 19de675..1315de4 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -3924,15 +3924,19 @@ static int smack_socket_sock_rcv_skb(struct sock
>>> *sk, struct sk_buff *skb)
>>>    	struct smack_known *skp = NULL;
>>>    	int rc = 0;
>>>    	struct smk_audit_info ad;
>>> +	u16 family = sk->sk_family;
>>>    #ifdef CONFIG_AUDIT
>>>    	struct lsm_network_audit net;
>>>    #endif
>>>    #if IS_ENABLED(CONFIG_IPV6)
>>>    	struct sockaddr_in6 sadd;
>>>    	int proto;
>>> +
>>> +	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
>>> +		family = PF_INET;
>>>    #endif /* CONFIG_IPV6 */
>>>
>>> -	switch (sk->sk_family) {
>>> +	switch (family) {
>>>    	case PF_INET:
>>>    #ifdef CONFIG_SECURITY_SMACK_NETFILTER
>>>    		/*
>>> @@ -3950,7 +3954,7 @@ static int smack_socket_sock_rcv_skb(struct sock
>>> *sk, struct sk_buff *skb)
>>>    		 */
>>>    		netlbl_secattr_init(&secattr);
>>>
>>> -		rc = netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
>>> +		rc = netlbl_skbuff_getattr(skb, family, &secattr);
>>>    		if (rc == 0)
>>>    			skp = smack_from_secattr(&secattr, ssp);
>>>    		else
>>> @@ -3963,7 +3967,7 @@ static int smack_socket_sock_rcv_skb(struct sock
>>> *sk, struct sk_buff *skb)
>>>    #endif
>>>    #ifdef CONFIG_AUDIT
>>>    		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
>>> -		ad.a.u.net->family = sk->sk_family;
>>> +		ad.a.u.net->family = family;
>>>    		ad.a.u.net->netif = skb->skb_iif;
>>>    		ipv4_skb_to_auditdata(skb, &ad.a, NULL);
>>>    #endif
>>> @@ -3977,7 +3981,7 @@ static int smack_socket_sock_rcv_skb(struct sock
>>> *sk, struct sk_buff *skb)
>>>    		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
>>>    					MAY_WRITE, rc);
>>>    		if (rc != 0)
>>> -			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
>>> +			netlbl_skbuff_err(skb, family, rc, 0);
>>>    		break;
>>>    #if IS_ENABLED(CONFIG_IPV6)
>>>    	case PF_INET6:
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
