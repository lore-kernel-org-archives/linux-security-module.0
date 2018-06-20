From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 21 Jun 2018 08:59:36 +0900
Subject: [PATCH v3 0/2] tpm: add support for nonblocking operation
In-Reply-To: <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
	<20180619131046.GC5609@linux.intel.com>
	<e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
Message-ID: <1529539176.4163.2.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-19 at 17:45 -0700, Tadeusz Struk wrote:
> On 06/19/2018 06:10 AM, Jarkko Sakkinen wrote:
> > On Tue, Jun 12, 2018 at 10:58:26AM -0700, Tadeusz Struk wrote:
> > > The TCG SAPI specification [1] defines a set of functions, which
> > > allows applications to use the TPM device in either blocking or
> > > non-blocking fashion. Each command defined by the specification
> > > has a corresponding Tss2_Sys_<COMMAND>_Prepare() and
> > > Tss2_Sys_<COMMAND>_Complete() call, which together with
> > > Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> > > mode of operation. Currently the TPM driver supports only
> > > blocking calls, which doesn't allow asynchronous IO operations.
> > > This patch changes it and adds support for nonblocking write and
> > > a new poll function to enable applications, which want to take
> > > advantage of this feature. The new functionality can be tested
> > > using standard TPM tools implemented in [2], together with
> > > modified TCTI from [3].
> > > 
> > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI
> > > _Version-1.1_Revision-22_review_030918.pdf
> > > [2] https://github.com/tpm2-software/tpm2-tools
> > > [3] https://github.com/tstruk/tpm2-tss/tree/async
> > 
> > For me the value is still a bit questionable. The benchmark looks a
> > bit flakky to give much figures how this would work with real world
> > workloads.
> > 
> > I read James response and I also have to question why not just a
> > worker thread in user space? TPM does only one command at a time
> > anyways.
> > 
> > Cannot take this in before I know that user space will (1) adapt to
> > this and (2) gain value compared to a worker thread.
> > 
> 
> Hi Jarkko,
> Thanks for reviewing the patch.
> There are applications/frameworks where a worker thread is not an
> option.
> Take for example the IoT use-cases and frameworks like IoT.js, or
> "Node.js for IoT".
> They are all single threaded, event-driven frameworks, using non-
> blocking I/O as the base of their processing model.

I'm slightly surprised by this statement.  I thought IoT Node.js
runtimes (of which there are far too many, so I haven't looked at all
of them) use libuv or one of the forks:

http://libuv.org/

As the basis for their I/O handling?  While libuv can do polling for
event driven interfaces it also support the worker thread model just as
easily:

http://docs.libuv.org/en/v1.x/threadpool.html

> Similarly embedded applications, which are basically just a single
> threaded event loop, quite often don't use threads because of
> resources constrains.

It's hard for me, as a kernel developer, to imagine any embedded
scenario using the Linux kernel that would not allow threads unless the
writers simply didn't bother with synchronization: The kernel schedules
at the threads level and can't be configured not to use them plus
threads are inherently more lightweight than processes so they're a
natural fit for resource constrained scenarios.

That's still not to say we shouldn't do this, but I've got to say I
think the only consumers would be old fashioned C code: the code we
used to write before we had thread libraries that did use signals and
poll() for a single threaded event driven monolith (think green
threads), because all the new webby languages use threading either
explicitly or at the core of their operation.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
