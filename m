From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 29 Nov 2017 19:16:17 -0800
Subject: [BUG] kernel stack corruption during/after Netlabel error
In-Reply-To: <alpine.LFD.2.20.1711301130330.17322@localhost>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
	<4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
	<alpine.LFD.2.20.1711301130330.17322@localhost>
Message-ID: <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On 11/29/2017 4:31 PM, James Morris wrote:
> On Wed, 29 Nov 2017, Casey Schaufler wrote:
>
>> I see that there is a proposed fix later in the thread, but I don't see
>> the patch. Could you send it to me, so I can try it on my problem?
> Forwarded off-list.

The patch does fix the problem I was seeing in Smack.

>
> Interestingly, I didn't see the KASAN output email from Stephen here.
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
