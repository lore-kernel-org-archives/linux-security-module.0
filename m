From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 7 Apr 2018 10:03:56 -0700
Subject: [GIT PULL] SELinux patches for v4.17
In-Reply-To: <1523120055.31267.13.camel@btinternet.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
	<CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
	<1523120055.31267.13.camel@btinternet.com>
Message-ID: <CA+55aFxo4Z3S7qG66esSL_qxg5jwzcFgZpYR0gRpto4Z_yghTQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Apr 7, 2018 at 9:54 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
>>
>> So please check my resolution, but also somebody should tell me
>> "Linus, you're a cretin, sctp_connect() doesn't want that
>> security_sctp_bind_connect() at all because it was already done by
>> XYZ"
>
> sctp_connect() or __sctp_connect() do not need to call
> security_sctp_bind_connect(). This is because the connect(2) call will
> handle the checks required via security_socket_connect():

Ok, thanks, that's exactly what I wanted to get.

Anyway, somebody should still verify that it all looks good in my
tree, but I don't actually expect the merge to have had any issues
even if the refactoring made it a bit more complex than most merges
are.

                      Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
