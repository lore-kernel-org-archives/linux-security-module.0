From: dsahern@gmail.com (David Ahern)
Date: Thu, 30 Nov 2017 08:44:18 -0700
Subject: [BUG] kernel stack corruption during/after Netlabel error
In-Reply-To: <1512039044.19682.12.camel@gmail.com>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
	<4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
	<alpine.LFD.2.20.1711301130330.17322@localhost>
	<ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
	<1512039044.19682.12.camel@gmail.com>
Message-ID: <b92c6b3d-5c7e-9859-4bb2-b1a0aa64d86b@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/30/17 3:50 AM, Eric Dumazet wrote:
> @@ -1631,24 +1659,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  
>  	th = (const struct tcphdr *)skb->data;
>  	iph = ip_hdr(skb);
> -	/* This is tricky : We move IPCB at its correct location into TCP_SKB_CB()
> -	 * barrier() makes sure compiler wont play fool^Waliasing games.
> -	 */
> -	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
> -		sizeof(struct inet_skb_parm));
> -	barrier();
> -
> -	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
> -	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
> -				    skb->len - th->doff * 4);
> -	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
> -	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
> -	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
> -	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
> -	TCP_SKB_CB(skb)->sacked	 = 0;
> -	TCP_SKB_CB(skb)->has_rxtstamp =
> -			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
> -
>  lookup:
>  	sk = __inet_lookup_skb(&tcp_hashinfo, skb, __tcp_hdrlen(th), th->source,
>  			       th->dest, sdif, &refcounted);

I believe moving the above is going to affect lookups with VRF. Let me
take a look before this gets committed.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
