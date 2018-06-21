From: tstruk@gmail.com (Tadeusz Struk)
Date: Wed, 20 Jun 2018 18:24:32 -0700
Subject: [PATCH v3 0/2] tpm: add support for nonblocking operation
In-Reply-To: <1529539176.4163.2.camel@HansenPartnership.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
	<20180619131046.GC5609@linux.intel.com>
	<e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
	<1529539176.4163.2.camel@HansenPartnership.com>
Message-ID: <0e46c2e9-af2b-550f-2b3d-98cbc1840bc1@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/20/2018 04:59 PM, James Bottomley wrote:
> I'm slightly surprised by this statement.  I thought IoT Node.js
> runtimes (of which there are far too many, so I haven't looked at all
> of them) use libuv or one of the forks:
> 
> http://libuv.org/
> 
> As the basis for their I/O handling?  While libuv can do polling for
> event driven interfaces it also support the worker thread model just as
> easily:
> 
> http://docs.libuv.org/en/v1.x/threadpool.html

Yes, it does polling:
http://docs.libuv.org/en/v1.x/design.html#the-i-o-loop

> 
>> Similarly embedded applications, which are basically just a single
>> threaded event loop, quite often don't use threads because of
>> resources constrains.
> It's hard for me, as a kernel developer, to imagine any embedded
> scenario using the Linux kernel that would not allow threads unless the
> writers simply didn't bother with synchronization: The kernel schedules
> at the threads level and can't be configured not to use them plus
> threads are inherently more lightweight than processes so they're a
> natural fit for resource constrained scenarios.
> 
> That's still not to say we shouldn't do this, but I've got to say I
> think the only consumers would be old fashioned C code: the code we
> used to write before we had thread libraries that did use signals and
> poll() for a single threaded event driven monolith (think green
> threads), because all the new webby languages use threading either
> explicitly or at the core of their operation.

Regardless of how it actually might be used, I'm happy that we agree on
that this *is* the right thing to do.
Thanks,
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
