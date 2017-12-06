From: davem@davemloft.net (David Miller)
Date: Wed, 06 Dec 2017 15:13:03 -0500 (EST)
Subject: [PATCH V2] selinux: Add SCTP support
In-Reply-To: <20171206101736.3217-1-richard_c_haines@btinternet.com>
References: <20171206101736.3217-1-richard_c_haines@btinternet.com>
Message-ID: <20171206.151303.1526119083235256934.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Richard Haines <richard_c_haines@btinternet.com>
Date: Wed,  6 Dec 2017 10:17:36 +0000

> The SELinux SCTP implementation is explained in:
> Documentation/security/SELinux-sctp.rst
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

No general objections from the networking side, so:

Acked-by: David S. Miller <davem@davemloft.net>

from me.  But if I were you I'd wait for some review from the
SCTP maintainers and experts. :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
