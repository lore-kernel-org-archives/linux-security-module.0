From: james.l.morris@oracle.com (James Morris)
Date: Wed, 1 Nov 2017 17:55:15 +1100 (AEDT)
Subject: [PATCH] KEYS: trusted: fix writing past end of buffer in
	trusted_read()
In-Reply-To: <20171026205744.105566-1-ebiggers3@gmail.com>
References: <20171026205744.105566-1-ebiggers3@gmail.com>
Message-ID: <alpine.LFD.2.20.1711011754050.6046@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 26 Oct 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>


David, this needs to go to Linus.

Are you planning on pushing out more fixes for this -rc or shuld I just 
send it up via my tree?


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
