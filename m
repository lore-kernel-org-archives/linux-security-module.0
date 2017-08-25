From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 25 Aug 2017 13:47:51 -0500
Subject: [PATCH V3 02/10] capabilities: intuitive names for cap gain status
In-Reply-To: <CALCETrUC4hjsCyOeT8R-L8KL5k5BCAfxQQC-XqMWhKMW8ZtvSQ@mail.gmail.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<9e3f99d3c2cbfee24fb3af7ec9b4cf93e4430112.1503459890.git.rgb@redhat.com>
	<CALCETrUC4hjsCyOeT8R-L8KL5k5BCAfxQQC-XqMWhKMW8ZtvSQ@mail.gmail.com>
Message-ID: <20170825184751.GA26620@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Andy Lutomirski (luto at kernel.org):
> On Wed, Aug 23, 2017 at 3:12 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Introduce macros cap_gained, cap_grew, cap_full to make the use of the
> > negation of is_subset() easier to read and analyse.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/commoncap.c |   16 ++++++++++------
> >  1 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index b7fbf77..6f05ec0 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -513,6 +513,12 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effec
> >                 *effective = true;
> >  }
> >
> > +#define cap_gained(field, target, source) \
> > +       !cap_issubset(target->cap_##field, source->cap_##field)
> > +#define cap_grew(target, source, cred) \
> > +       !cap_issubset(cred->cap_##target, cred->cap_##source)
> > +#define cap_full(field, cred) \
> > +       cap_issubset(CAP_FULL_SET, cred->cap_##field)
> 
> I read this several times and I can't figure out what "gain" means,
> what "grew" means, and why it's more intuitive that they signify weird

gain means the new set has bits which the old didn't.  It's clearer
precisely because it describes the intent rather than the mechanism.

> permutations of the parameters.  I also don't know what "source" and
> "target" mean in this context.

Source and target might be better named 'old' and 'new' or something
like that, though I didn't found source and target to be confusing.

> Can you clearly articulate how this is better than the status quo?

Yes, it describes what we're checking for, making the code more
self-documenting.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
