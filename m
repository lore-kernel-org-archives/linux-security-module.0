From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Tue, 7 Aug 2018 10:54:56 -0700
Subject: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
In-Reply-To: <1533602145.3159.23.camel@HansenPartnership.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
	<153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
	<1533596748.3159.19.camel@HansenPartnership.com>
	<1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
	<1533602145.3159.23.camel@HansenPartnership.com>
Message-ID: <7acd9a7e-4643-001d-a227-e7f80cdbf90f@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/06/2018 05:35 PM, James Bottomley wrote:
> On Mon, 2018-08-06 at 17:09 -0700, Tadeusz Struk wrote:
>> On 08/06/2018 04:05 PM, James Bottomley wrote:
>>> For an async interface, shouldn't I be able to queue an
>>> arbitrary number of commands without blocking?
>>
>> That was the approach in the v1 version of this patch, but
>> Jason requested this to be changed so that only one command
>> at a time can be processed.
> 
> He did?  I don't remember that.  I think he told you the TPM itself can
> only process one operation at once so you didn't need an elaborate
> allocation scheme.

Right, but the allocation was needed only if more than one command
would be queued at a given time.

> 
> But anyway, if you're happy to limit the interface to block after one
> command is issued, how is it useful as an asynchronous interface?  I
> thought the whole argument for the patch was to avoid the producer-
> consumer approach which is possible with the current interface and to
> use a fully event driven polling interface which can be implemented
> single threaded.  If you can block in submission, this latter isn't
> really possible because your interface isn't really asynchronous.

Well it is. This change makes the interface non-blocking and adds a poll
interface. Application can submit a command in a non-blocking way, go
do something else and get a notification via poll mechanism when the
response is ready to consume. We could implement it in a way that more
commands can be queued at a time, but in this case there would need to
be limit on how many commands can be en-queued. Allowing to send many
commands without any limit could be harmful. So what would it be? 10? 50?
And what would happen if an application sends 10 commands only to find
out the the first has failed? The drive doesn't know about that as it
only copies buffers back and forth. There will need to be an interface
for the application to rollback all the enqueued commands and stat over.
Also what would be the use case for this? TPM is not a crypto accelerator
where one submits a batch of buffers for encryption. Usually the sequence
of commands requires that subsequent command needs to refer the result
from the previous one. For example first command creates a key and the
second does something with it passing a handle to the key created in step
one. Do you have any particular scenario in mind for multiple commands
in-flight?

Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
