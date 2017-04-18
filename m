From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Apr 2017 08:49:10 -0700
Subject: [kernel-hardening] Re: [PATCH 1/4] added SECURITY_TIOCSTI_RESTRICT
	kernel config
In-Reply-To: <20170418144057.1e9c2103@lxorguk.ukuu.org.uk>
References: <20170417060706.28674-1-matt@nmatt.com>
	<20170417060706.28674-2-matt@nmatt.com>
	<20170417065055.GA21022@kroah.com>
	<20170418144057.1e9c2103@lxorguk.ukuu.org.uk>
Message-ID: <CAGXu5j+mP784rGqx1CWOOXM=AhAN7EegRZxO_=OG0y6k0hQs+g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 18, 2017 at 6:40 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> Since tty sessions are usually separated by different users, how would
>> they have the same one and yet need something like this?
>>
>> Also, why not put this in the tty config section?
>
> The normal attack use case people argue about is a rogue process on the
> users machine sitting there waiting until the user has logged in to a
> remote machine and is idle and then doing stuff.

It's still a threat, though, and adding this with default n to allow
the more paranoid builders a chance to mitigate it seems reasonable to
me.

> Attackers of course don't bother doing that because it's easier to get
> the user to run a different ssh client instead.

Attackers will always take the easiest route, so we have to keep
killing the low hanging fruit.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
