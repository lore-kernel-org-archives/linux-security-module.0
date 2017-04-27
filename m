From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 26 Apr 2017 22:52:38 -0400
Subject: [RFC][PATCH] audit: add ambient capabilities to CAPSET and
	BPRM_FCAPS records
In-Reply-To: <20170427024156.GH25861@madcap2.tricolour.ca>
References: <fb96ad9e604033a5d51607bdbb0b46f50442f5b6.1491471625.git.rgb@redhat.com>
	<CAHC9VhSUc944RmVHi93m7Ht2D=gjdWcK6Lsc6Om5M9qvj7DB9g@mail.gmail.com>
	<20170427024156.GH25861@madcap2.tricolour.ca>
Message-ID: <20170427025238.GI25861@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-04-26 22:41, Richard Guy Briggs wrote:
> On 2017-04-26 16:04, Paul Moore wrote:
> > On Fri, Apr 7, 2017 at 10:17 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Capabilities were augmented to include ambient capabilities in v4.3
> > > commit 58319057b784 ("capabilities: ambient capabilities").
> > >
> > > Add ambient capabilities to the audit BPRM_FCAPS and CAPSET records.
> > >
> > > The record contains fields "old_pp", "old_pi", "old_pe", "new_pp",
> > > "new_pi", "new_pe" so in keeping with the previous record
> > > normalizations, change the "new_*" variants to simply drop the "new_"
> > > prefix.
> > 
> > Help me out and remind me of those previous field rename
> > patches/commits where "new_X" became "X"?
> 
> aa589a13b5d00d3c643ee4114d8cbc3addb4e99f ("audit: remove superfluous
> new- prefix in AUDIT_LOGIN messages")
> 
> I had thought there were more.
> 
> And I'm now noticing that audit_log_feature_change() could use the same
> treatment and so could audit_receive_msg()'s AUDIT_TTY_SET.

I should add it was Steve Grubb who specifically asked for this change
so there were only 2 potential names per field rather than 3, since we
should just use the canonical field name to report the new/current
value and not clutter the name field further.

> (And much earlier: ac03221a4fdda9bfdabf99bcd129847f20fc1d80 ("[PATCH]
> update of IPC audit record cleanup")
> 
> > paul moore
> 
> - RGB

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
