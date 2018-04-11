From: Golden_Miller83@protonmail.ch (Jordan Glover)
Date: Wed, 11 Apr 2018 17:05:04 -0400
Subject: [PATCH 01/24] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
	<CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
Message-ID: <8z0aRQyD-6Krqntk8UD9WQjK5JSqEai2Pt5oeFU2EplgxoWiHlX5nlJXwCDHQ1WcS1oIprXimgz7UvwHCWDB9Z3dYFrEmZmtkEJSqaYMel8=@protonmail.ch>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On April 11, 2018 8:09 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Apr 11, 2018 at 9:24 AM, David Howells dhowells at redhat.com wrote:
> 
> > Provide a single call to allow kernel code to determine whether the system
> > 
> > should be locked down, thereby disallowing various accesses that might
> > 
> > allow the running kernel image to be changed, including:
> > 
> > -   /dev/mem and similar
> > -   Loading of unauthorised modules
> > -   Fiddling with MSR registers
> > -   Suspend to disk managed by the kernel
> > -   Use of device DMA
> 
> So what I stlll absolutely detest about this series is that I think
> 
> many of these things should simply be done as separate config options.
> 
> For example, if the distro is sure that it doesn't need /dev/mem, then
> 
> why the hell is this tied to "lockdown" that then may have to be
> 
> disabled because other changes may not be acceptable (eg people may
> 
> need that device DMA, or whatever).
> 
> If that /dev/mem access prevention was just instead done as an even
> 
> stricter mode of the existing CONFIG_STRICT_DEVMEM, it could just be
> 
> enabled unconditionally.

CONFIG_DEVMEM=n

> 
> So none of these patches raise my hackles per se. But what continues
> 
> to makes me very very uncomfortable is how this is all tied together.
> 
> Why is this one magical mode that then - because it has such a big
> 
> impact - has to be enabled/disabled as a single magical mode and with
> 
> very odd rules?
> 
> I think a lot of people would be happier if this wasn't so incestuous
> 
> and mixing together independent things under one name, and one flag.
> 
> I think a lot of the secure boot problems were exacerbated by that mixup.
> 
> So I would seriously ask that the distros that have been using these
> 
> patches look at which parts of lockdown they could make unconditional
> 
> (because it doesn't break machines), and which ones need that escape
> 
> clause.
> 
> Linus
> 

?Jordan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
