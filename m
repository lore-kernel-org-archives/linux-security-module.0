From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 25 Oct 2017 15:18:48 +0200
Subject: Proposal: rename tpm1_eventlog.c and tpm2_eventlog.c
In-Reply-To: <CA+zpnLft_o-c2cRxtUEoAPbYiiLzmLqAPYwrkFDdVoyk5t6Zfw@mail.gmail.com>
References: <20171024222148.gwnkj5vqsyj43qer@linux.intel.com>
	<CA+zpnLft_o-c2cRxtUEoAPbYiiLzmLqAPYwrkFDdVoyk5t6Zfw@mail.gmail.com>
Message-ID: <20171025131848.3il7j5rw7nt7e2l6@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 10:43:10AM +0200, Thiebaud Weksteen wrote:
> On Wed, Oct 25, 2017 at 12:21 AM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > I noticed when making slides for KS that the naming for event log stuff
> > that the naming is so broken that it is hard to understand the code.
> > Here it really would make sense to have a patch set just to clean up the
> > cruft.
> 
> Agreed and happy to help.

That would be great! Thank you.

> > Random examples of more senseful naming:
> >
> > * tpm2_bios_measurements_start() should be rather something like
> >   tpm_eventlog_seq_agile_start().
> > * tpm_bios_measurements_start() should be rather something like
> >   tpm_eventlog_seq_sha1_start().
> >
> > Corresponding structs would be tpm_eventlog_agile_seq_ops and
> > tpm_eventlog_sha1_seq_ops.
> >
> > Finally, I would place the file operations, being so complicated, in
> > separate files:
> >
> > * tpm_eventlog_seq_sha1.c
> > * tpm_eventlog_seq_eventlog.c
> 
> I assume you meant tpm_eventlog_seq_agile.c ?

Yes.

> >
> > And move all the management code that is right now illogically located
> > in tpm1_eventlog.c to tpm_eventlog.c that would be the entry point for
> > the event log.
> >
> > The code is laid out so badly right now that I have really hard time
> > understanding it if I haven't looked at it within last couple of weeks.
> > It's really a trainwreck at the moment. We must clean up it up fast.
> >
> > Getting this done will help me to review patches to this area faster
> > so it would be a benefit for everyone. The current structure makes every
> > event log patch a pain to review.
> 
> Since this may conflict with the last patch set I sent, are you happy
> for me to base this new set on tpmdd/master?

What about this: you do an updated version of your patch set that
includes these clean ups?

PS. Sorry for slowness with your patches. I've just had a lot of stuff
going on lately. They are 2nd in my priority queue right after
CVE-2017-15361.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
