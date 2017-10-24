From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 24 Oct 2017 18:23:59 +0200
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
Message-ID: <20171024162359.tf5xulhlhokmuxh5@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 24, 2017 at 09:21:15PM +0530, PrasannaKumar Muralidharan wrote:
> On 24 October 2017 at 21:14, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Mon, Oct 23, 2017 at 10:31:39AM -0600, Jason Gunthorpe wrote:
> >> On Mon, Oct 23, 2017 at 10:07:31AM -0400, Stefan Berger wrote:
> >>
> >> > >-int tpm_pcr_extend(u32 chip_num, int pcr_idx, const u8 *hash)
> >> > >+int tpm_pcr_extend(int pcr_idx, const u8 *hash)
> >> > >  {
> >> >
> >> >
> >> > I think every kernel internal TPM driver API should be called with the
> >> > tpm_chip as a parameter. This is in foresight of namespacing of IMA where we
> >> > want to provide the flexibility of passing a dedicated vTPM to each
> >> > namespace and IMA would use the chip as a parameter to all of these
> >> > functions to talk to the right tpm_vtpm_proxy instance. From that
> >> > perspective this patch goes into the wrong direction.
> >>
> >> Yes, we should ultimately try and get to there.. Someday the
> >> tpm_chip_find_get() will need to become namespace aware.
> >>
> >> But this patch is along the right path, eliminating the chip_num is
> >> the right thing to do..
> >>
> >> > >-  tpm2 = tpm_is_tpm2(TPM_ANY_NUM);
> >> > >+  tpm2 = tpm_is_tpm2();
> >> > >   if (tpm2 < 0)
> >> > >           return tpm2;
> >> > >
> >> > >@@ -1008,7 +1007,7 @@ static int trusted_instantiate(struct key *key,
> >> > >   switch (key_cmd) {
> >> > >   case Opt_load:
> >> > >           if (tpm2)
> >> > >-                  ret = tpm_unseal_trusted(TPM_ANY_NUM, payload, options);
> >> > >+                  ret = tpm_unseal_trusted(payload, options);
> >>
> >> Sequences like this are sketchy.
> >>
> >> It should be
> >>
> >> struct tpm_chip *tpm;
> >>
> >> tpm = tpm_chip_find_get()
> >> tpm2 = tpm_is_tpm2(tpm);
> >>
> >> [..]
> >>
> >> if (tpm2)
> >>      ret = tpm_unseal_trusted(tpm, payload, options);
> >>
> >> [..]
> >>
> >> tpm_put_chip(tpm);
> >>
> >> As hot plug could alter the 'tpm' between the two tpm calls.
> >>
> >> Jason
> >
> > This patch just removes bunch of dead code. It does not change existing
> > semantics. What you are saying should be done after the dead code has
> > been removed. This commit is first step to that direction.
> >
> > /Jarkko
> 
> Please check the RFC [1]. It does use chip id. The rfc has issues and
> has to be fixed but still there could be users of the API.
> 
> 1. https://www.spinics.net/lists/linux-crypto/msg28282.html
> 
> Regards,
> PrasannaKumar

1. Every user in the kernel is using TPM_ANY_NUM, which means there are
   no other users.
2. Moving struct tpm_rng to the TPM client is architecturally
   uacceptable.
3. Using zero deos not give you any better guarantees on anything than
   just using TPM_ANY_NUM.

Why this patch is not CC'd to linux-integrity? It modifies the TPM
driver. And in the worst way.

Implementing the ideas that Jason explained is the senseful way to
get stable access. modules.dep makes sure that the modules are loaded
in the correct order.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
