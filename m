From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 16:14:29 +0200
Subject: Proposal: rename tpm1_eventlog.c and tpm2_eventlog.c
In-Reply-To: <20171025131848.3il7j5rw7nt7e2l6@linux.intel.com>
References: <20171024222148.gwnkj5vqsyj43qer@linux.intel.com>
	<CA+zpnLft_o-c2cRxtUEoAPbYiiLzmLqAPYwrkFDdVoyk5t6Zfw@mail.gmail.com>
	<20171025131848.3il7j5rw7nt7e2l6@linux.intel.com>
Message-ID: <20171026141429.nnmc2ks4m2bm6yhx@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 03:18:48PM +0200, Jarkko Sakkinen wrote:
> > Since this may conflict with the last patch set I sent, are you happy
> > for me to base this new set on tpmdd/master?
> 
> What about this: you do an updated version of your patch set that
> includes these clean ups?
> 
> PS. Sorry for slowness with your patches. I've just had a lot of stuff
> going on lately. They are 2nd in my priority queue right after
> CVE-2017-15361.

This is an awful idea as your patch is in great shape and we want to
land that feature ASAP. Lets land your patches first and then plan how
to do the clean up.

I have some other suggestions for the clean up work that require even
more work. Mainly: I think it would make sense to have an eventlog
subdirectory for the eventlog as it's growing so complex.

What do you think?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
