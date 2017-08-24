From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:37:18 -0500
Subject: [PATCH V3 02/10] capabilities: intuitive names for cap gain status
In-Reply-To: <20170824161912.GI24692@madcap2.tricolour.ca>
References: <cover.1503459890.git.rgb@redhat.com>
	<9e3f99d3c2cbfee24fb3af7ec9b4cf93e4430112.1503459890.git.rgb@redhat.com>
	<20170824160344.GB10515@mail.hallyn.com>
	<20170824161912.GI24692@madcap2.tricolour.ca>
Message-ID: <20170824163717.GK10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> On 2017-08-24 11:03, Serge E. Hallyn wrote:
> > Quoting Richard Guy Briggs (rgb at redhat.com):
> > > Introduce macros cap_gained, cap_grew, cap_full to make the use of the
> > > negation of is_subset() easier to read and analyse.
> > > 
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  security/commoncap.c |   16 ++++++++++------
> > >  1 files changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > index b7fbf77..6f05ec0 100644
> > > --- a/security/commoncap.c
> > > +++ b/security/commoncap.c
> > > @@ -513,6 +513,12 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effec
> > >  		*effective = true;
> > >  }
> > >  
> > 
> > It's subjective and so might be just me, but I think I'd find it easier
> > to read if it was cap_gained(source, target, field) and cap_grew(cred, source, target)
> 
> In more than one place, I wanted to put the parameter that I was trying
> to read aloud closest to the function name to make reading it flow
> better, leaving the parameters less critical to comprehension towards
> the end.

And I see that in the final patch it looks nicer the way you have it.

> > This looks correct though, so either way
> > 
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> Thanks.  Did you want to put this through, or send it through Paul's
> audit tree?

If Paul's around I'm happy to have it go through his tree.

thanks,
-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
