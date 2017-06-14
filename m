From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 14 Jun 2017 09:32:01 -0700
Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
In-Reply-To: <c11f0d61-02c9-f71c-c983-1d34845cedbe@samsung.com>
References: <CGME20170609024301epcas3p42a76d6e0e1c8ef38636c08bd478a9d59@epcas3p4.samsung.com>
	<3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
	<c11f0d61-02c9-f71c-c983-1d34845cedbe@samsung.com>
Message-ID: <22c51600-22c6-3217-4b9c-fd1cfebce962@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/14/2017 6:10 AM, Rafa? Krypa wrote:
> On 2017-06-09 04:41, Casey Schaufler wrote:
>> Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
>
> Hi Casey,
> Thank you for sharing your code. I have one remark, on top of what Piotr Sawicki already wrote.
>
> Back in 2014, commit 69f287ae6fc83 ("Smack: secmark support for netfilter") made some important change in Smack behavior regarding access control on loopback. The case I have in mind can be described as follows:
> - Default Smack settings for netlabel (Documentation/security/Smack.txt recommends "127.0.0.1 -CIPSO\n0.0.0.0/0 @")
> - Loopback network interface with IPv4 address 127.0.0.1
> - An external network address, for example eth0 with IPv4 address 192.168.0.10
> - A server program listening on some port on all interfaces (0.0.0.0)
>
> Now if another application wants to connect to the server on loopback, but Smack doesn't allow that, it will be prohibited if connection targets 127.0.0.1. But if the client uses 192.168.0.10 as destination address, it will work without CIPSO and be allowed.

The default I'm proposing will have "0.0.0.0/32 -CIPSO",
which matches the traditional behavior with the exception
of processes running with the ambient label. You would only
use "0.0.0.0/32 @" if you wanted to allow all processes
to communicate on the internet. If you chose
"0.0.0.0/32 Internet" processes with Smack rules allowing
mutual write with "Internet" would be able to talk off-box.


> The client application could also play tricks and use IPv4-mapped IPv6 addresses like ::ffff:127.0.0.1 or ::ffff:192.168.0.10. To prevent that, Smack would have to be configured to use CIPSO for all IP addresses assigned to local network interfaces, not only 127.0.0.1. This means active updating of netlabel configuration if interfaces are hot-plugged or have dynamically assigned IP address.
>
> When your patch with secmark support appeared in v4.0, all that was needed to prevent local communication on loopback device on addresses other than 127.0.0.1 was enabling CONFIG_SECURITY_SMACK_NETFILTER. With that option enabled, secmark was set on all locally generated packets. Smack preferred secmark to netlabel policy when checking access for packet delivery. Local applications needed to have mutual write access to communicate over loopback, regardless of netlabel configuration.
>
> Now this proposed patch seems to revert that change back to pre-v4.0 behavior.

The secmark is still checked first in smack_socket_sock_rcv_skb().
There's an inconsistency in smack_inet_conn_request(), where the
host label is checked first. I'll change that so the secmark check
comes first. I think that will address this concern.

> Is that intended? Let's say that a system administrator wants to prevent local programs from talking to each other while enabling both of them to make external connections. Is the recommended way of achieving it to manually enable CIPSO for all local IP addresses in netlabel and keep it updated when network configuration changes?
>
>
> Best regards,
> Rafal Krypa
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
