From: tixxdz@gmail.com (Djalal Harouni)
Date: Mon, 27 Nov 2017 22:31:54 +0100
Subject: [PATCH v5 next 0/5] Improve Module autoloading infrastructure
In-Reply-To: <CA+55aFxcte0puN32cV25p8Ex2PKzb3mug-OzpzWWw1EvY35=AA@mail.gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
	<CA+55aFwhmgaoHUtCx2=m4SWBtG4dtmY3M8qHLjwe0UaLkBz_eA@mail.gmail.com>
	<CA+55aFxcte0puN32cV25p8Ex2PKzb3mug-OzpzWWw1EvY35=AA@mail.gmail.com>
Message-ID: <CAEiveUfw4J2NZ3Ea1Cc4kXpAj0iWKSZjKzYA8ShPZBVKyOd5BA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

On Mon, Nov 27, 2017 at 8:12 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 27, 2017 at 11:02 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Now, the above will not necessarily work with a legacy /dev/ directory
>> where al the nodes have been pre-populated, and opening the device
>> node is supposed to load the module. So _historically_ we did indeed
>> load modules as normal users. But does that really happen any more?
>
> Sadly, it looks like bluetoothd actually does expect to load the
> bt-proto-XYZ modules with no capabilities at all.
>
> So apparently we really do depend on not needing capabilities for
> module loading.
>
> Oh well.

Yes DCCP is unprivileged, tun and all tunneling, some md drivers, some
crypto, and device drivers... fs modules can be loaded inside
usernamespaces, and maybe when some request requires external symbols
too...

However tunneling helps to solve real usecases, so that's why the
backward compatibility and opt-in.

I do perfectly understand that opt-in is not the best choice, however
these patchset includes a per process tree, and given that lot of code
is running in containers and sandboxes, it is better than nothing. I
will follow up later with patches to the major ones especially when we
force the flag by default. Ubuntu was said to be owned in a past
security contest due to this kind of things, and now since they have
ubuntu snaps or apps they can set the flag, and others will follow.

Thanks!

>                  Linus



-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
