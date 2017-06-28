From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 28 Jun 2017 09:28:50 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <CAOQ4uxhiSHEXzWN7=g-nmu=ebpv7hkXszW03JZ4UJkcjTeH+oQ@mail.gmail.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
	<20170628054138.GA15939@mail.hallyn.com>
	<CAOQ4uxhiSHEXzWN7=g-nmu=ebpv7hkXszW03JZ4UJkcjTeH+oQ@mail.gmail.com>
Message-ID: <20170628142850.GA24489@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Amir Goldstein (amir73il at gmail.com):
> On Wed, Jun 28, 2017 at 8:41 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Hi Amir,
> >
> > I was liking the prefix at first, but I'm actually not sure it's worth
> > it.  THe main advantage would be so that checking for namespace or other
> > tags could be done always at the same offset simplifying the parser.
> > But since we will want to only handle namespacing for some tags, and
> > potentially differently for each task, it won't actually be simpler, I
> > don't think.
> >
> > On the other hand we do want to make sure that the syntax we use is
> > generally usable, so I think simply specifying that >1 tags can each
> > be separate by '@' should suffice.  So for now we'd only have
> 
> Serge,
> 
> I am not sure I am parsing what you are saying correctly (pun intended).
> Can you give some examples of xattr names with several @.
> 
> >
> >         security.capability at uid=100000
> >
> > soon we'd hopefully have
> >
> >         security.ima at uid=100000
> >
> 
> IIUC, the xattr names above should be parsed as:
> 
>         security.(([ima|capability])@(uid=100000)

not sure what you mean by the parentheses.  Point in these two
examples being that only uid= would be accepted as 'tags', and
only ima and capability would support the tag.  As we'd discussed
we might support uid= (with no number) as indicating any namespace
not mapping kuid 0 would work.

> > and eventually trusted.blarb at foo=bar
> >
> 
> But the trusted xattr name should be parsed as:
> 
>         (trusted.blarb)@(uid=100000)

Sorry, my point there wasn't trusted, I had meant to put in more
tags, which was the point:

	security.capability at uid=100000 at smack=container_x

We don't yet know what smack= would mean, but we do know that at
some point there may be > 1 tags.

Importantly, in order to not limit our future behavior, for now
we would refuse writing >1 tags.  (That way we don't risk the problem,
in the future, that someone can boot an older kernel andw rite a xattr
without all the privileges which the new kernel requires.)

> Otherwise it won't be able to pass the xattr_is_trusted() test
> which looks only at the trusted prefix.
> 
> So we can write it like this, if it makes sense for the parser:
>         trusted at uid=100000.blarb

That's actually specifically what I'm arguing against.  I'm arguing
that the full xattr should come first, as we should not bother
checking for tags until we've verified that the xattr supports them.

> But I don't think that trusted.foo should have a different
> userns behavior than trusted.bar down the road.

Perhaps not for trusted, but perhaps it will.  And for security.*
it definately does.  Selinux does not support namespace tags.
Smack one day may, but perhaps with different behavior than ima.

> Admittedly, I am not so much of a security developer myself,
> so I prefer to let Casey be the spokesman for the '.ns' prefix.
> Casey's proposal seems right to me:
> 
>         security.ns at uid=1000@@.capability

Right I was going to reply to his email, but yours seemed to come
earlier so I picked it :)  I wasn't trying to pick on you :)

> We can also stick to a more conventional syntax of a perfect
> new namespace 'security.ns', which encapsulates the unprivileged

If we were going this route I definately would have preferred
security.ns at uid=1000@@.capability.

I've cc:d linux-api at this point as it seems the right thing to
do :)

thanks,
-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
