From: rgb@redhat.com (Richard Guy Briggs)
Date: Fri, 1 Sep 2017 06:18:43 -0400
Subject: [PATCH V3 02/10] capabilities: intuitive names for cap gain status
In-Reply-To: <20170828110835.GM24692@madcap2.tricolour.ca>
References: <cover.1503459890.git.rgb@redhat.com>
	<9e3f99d3c2cbfee24fb3af7ec9b4cf93e4430112.1503459890.git.rgb@redhat.com>
	<20170824160344.GB10515@mail.hallyn.com>
	<20170824161912.GI24692@madcap2.tricolour.ca>
	<20170824163717.GK10515@mail.hallyn.com>
	<CAGXu5jJbgoeBpaHt=2u+KkSsewwVdjZmtxMMuFOv927XkW0uig@mail.gmail.com>
	<20170828091908.GL24692@madcap2.tricolour.ca>
	<20170828110835.GM24692@madcap2.tricolour.ca>
Message-ID: <20170901101843.GZ29957@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-08-28 07:08, Richard Guy Briggs wrote:
> On 2017-08-28 05:19, Richard Guy Briggs wrote:
> > On 2017-08-24 12:06, Kees Cook wrote:
> > > On Thu, Aug 24, 2017 at 9:37 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > Quoting Richard Guy Briggs (rgb at redhat.com):
> > > >> On 2017-08-24 11:03, Serge E. Hallyn wrote:
> > > >> > Quoting Richard Guy Briggs (rgb at redhat.com):
> > > >> > > Introduce macros cap_gained, cap_grew, cap_full to make the use of the
> > > >> > > negation of is_subset() easier to read and analyse.
> > > >> > >
> > > >> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > >> > > ---
> > > >> > >  security/commoncap.c |   16 ++++++++++------
> > > >> > >  1 files changed, 10 insertions(+), 6 deletions(-)
> > > >> > >
> > > >> > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > >> > > index b7fbf77..6f05ec0 100644
> > > >> > > --- a/security/commoncap.c
> > > >> > > +++ b/security/commoncap.c
> > > >> > > @@ -513,6 +513,12 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effec
> > > >> > >           *effective = true;
> > > >> > >  }
> > > >> > >
> > > >> >
> > > >> > It's subjective and so might be just me, but I think I'd find it easier
> > > >> > to read if it was cap_gained(source, target, field) and cap_grew(cred, source, target)
> > > >>
> > > >> In more than one place, I wanted to put the parameter that I was trying
> > > >> to read aloud closest to the function name to make reading it flow
> > > >> better, leaving the parameters less critical to comprehension towards
> > > >> the end.
> > > >
> > > > And I see that in the final patch it looks nicer the way you have it.
> > > >
> > > >> > This looks correct though, so either way
> > > >> >
> > > >> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > >>
> > > >> Thanks.  Did you want to put this through, or send it through Paul's
> > > >> audit tree?
> > > >
> > > > If Paul's around I'm happy to have it go through his tree.
> > > 
> > > Is this series based against -next with the changes that touch commoncap.c?
> > 
> > This series is against pcmoore's audit/next tree (I know I'm missing two
> > commits but they pose no conflict.).
> > 
> > Which -next tree are you talking about?  I might guess
> > linux-security/next or linux-next/master (I have at least a dozen "next"
> > in my git repo config.)
> > 
> > I did eventually find your patches in sfr's tree and in your for-next/kspp branch.
> > 
> > I'll have a look at the commoncap.c changes including the elimination of cap_effective.
> > 
> > > Also, did you validate this with the existing LTP tests and selftests?
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/secureexec&id=ee67ae7ef6ff499137292ac8a9dfe86096796283
> > 
> > No.  I will look into doing that.  Thanks for the suggestion.

Ok, I'm running the kernel self-test

	make TARGETS="capabilities" kselftest

and getting a good way through it and then hit this on an unmodified kernel:

	[RUN]   +++ Tests with uid != 0 +++
	[NOTE]  Using global UIDs for tests
	[OK]    Child succeeded
	test_execve: chdir to private tmpfs: Permission denied
	[FAIL]  Child failed
	selftests:  test_execve [FAIL]

Is this a known limitation or have I got something weird in my runtime
environment that is killing it at this part of the test?

> > I see that bprm->cap_effective has vanished, so that will affect at least one hunk.
> 
> And I spoke too soon and didn't notice this was in the bprm struct and
> not the cred struct, so I think were're fine there.  I'll go ahead and
> rebase on your commoncap.c changes as well as run the ltp and kernel
> self-test validation tests.
> 
> > > Kees Cook
> > 
> > - RGB
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
