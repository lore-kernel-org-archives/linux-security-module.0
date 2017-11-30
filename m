From: james.l.morris@oracle.com (James Morris)
Date: Thu, 30 Nov 2017 11:31:21 +1100 (AEDT)
Subject: [BUG] kernel stack corruption during/after Netlabel error
In-Reply-To: <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
	<4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
Message-ID: <alpine.LFD.2.20.1711301130330.17322@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 29 Nov 2017, Casey Schaufler wrote:

> I see that there is a proposed fix later in the thread, but I don't see
> the patch. Could you send it to me, so I can try it on my problem?

Forwarded off-list.

Interestingly, I didn't see the KASAN output email from Stephen here.


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
