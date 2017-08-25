From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 25 Aug 2017 13:53:21 -0500
Subject: [PATCH V3 07/10] capabilities: remove a layer of conditional logic
In-Reply-To: <CALCETrXoY_DAMAdcFcOY67SnyW3RaMn=Qa_wFnt0iYNRt1HTHQ@mail.gmail.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<b656082f8697c02165b4240ecf4ae60fe08811dd.1503459890.git.rgb@redhat.com>
	<CALCETrXoY_DAMAdcFcOY67SnyW3RaMn=Qa_wFnt0iYNRt1HTHQ@mail.gmail.com>
Message-ID: <20170825185320.GC26620@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Andy Lutomirski (luto at kernel.org):
> On Wed, Aug 23, 2017 at 3:12 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Remove a layer of conditional logic to make the use of conditions
> > easier to read and analyse.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/commoncap.c |   13 ++++++-------
> >  1 files changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 5d81354..ffcaff0 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -551,13 +551,12 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
> >  {
> >         bool ret = false;
> >
> > -       if (cap_grew(effective, ambient, cred)) {
> > -               if (!cap_full(effective, cred) ||
> > -                   !is_eff(root, cred) || !is_real(root, cred) ||
> > -                   !root_privileged()) {
> > -                       ret = true;
> > -               }
> > -       }
> > +       if (cap_grew(effective, ambient, cred) &&
> > +           (!cap_full(effective, cred) ||
> > +            !is_eff(root, cred) ||
> > +            !is_real(root, cred) ||
> > +            !root_privileged()))
> > +               ret = true;
> 
> I'm trying to give this whole series the benefit of the doubt.  Here's
> what happens when I try to read this:
> 
> Did effective grow ambient caps?  No, makes no sense.  Did ambient
> grow effective caps?  No, not that either.  Is effective more fully
> grown than ambient?  That's probably it, but that sounds really weird.

..  True, that reads weird when you look at it that way.  Maybe we
can do better with the arguments passed to those new helpers.

> The rest would IMO be clearer if you named the helpers ruid_eq and
> euid_eq instead of is_eff and is_real.
> 
> >         return ret;
> >  }
> >
> > --
> > 1.7.1
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
