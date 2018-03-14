From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 14 Mar 2018 16:42:51 -0500
Subject: [PATCH v3 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <874F0391-1E88-498E-970B-78674057028D@oracle.com> (Chuck Lever's
	message of "Wed, 14 Mar 2018 16:34:32 -0400")
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
	<CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
	<1521032461.3547.404.camel@linux.vnet.ibm.com>
	<877eqer5r6.fsf@xmission.com>
	<1521049841.3547.500.camel@linux.vnet.ibm.com>
	<279C5F8D-9A75-44C7-8287-023F634BB3A0@oracle.com>
	<87in9yo2xq.fsf@xmission.com>
	<874F0391-1E88-498E-970B-78674057028D@oracle.com>
Message-ID: <87a7vamizo.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Chuck Lever <chuck.lever@oracle.com> writes:

>> On Mar 14, 2018, at 3:46 PM, ebiederm at xmission.com wrote:
>> 
>> Chuck Lever <chuck.lever@oracle.com> writes:
>> 
>>>> On Mar 14, 2018, at 1:50 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>>> 
>>>> On Wed, 2018-03-14 at 11:17 -0500, Eric W. Biederman wrote:
>>>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>>>> 
>>>>>> On Wed, 2018-03-14 at 08:52 +0100, Stef Bon wrote:
>>>>>>> I do not have any comments about the patches but a question.
>>>>>>> I completely agree that the files can change without the VFS knowing
>>>>>>> about it, but isn't that in general the case with filesystems with a
>>>>>>> backend shared with others (network fs's?).
>>>>>> 
>>>>>> Right, the problem is not limited to fuse, but needs to be addressed
>>>>>> before unprivileged fuse mounts are upstreamed.
>>>>>> 
>>>>>> Alban's response to this question:
>>>>>> https://marc.info/?l=linux-kernel&m=151784020321045&w=2
>>>>> 
>>>>> Which goes to why it is a flag that get's set.
>>>>> 
>>>>> All of this just needs a follow-up patch to update every filesystem
>>>>> that does not meet ima's requirements.
>>>> 
>>>> Currently files on remote filesystems are measured/appraised/audited
>>>> once.  With the new flags, our options would be to either fail the
>>>> signature verification or constantly re-measure/re-appraise files on
>>>> remote file systems.  Neither option seems like the right solution.
>> 
>> They are measured/appraised/audited once, and you can not trust that at
>> all because you don't know when the files are going to be different.
>> 
>> So either keeping the filesystem out of the ima game or failing sounds
>> like the right answer to me.  At least until you can get better
>> information from the filesystem.
>> 
>>> Being new to this game, I may be making a bad assumption, but I thought
>>> that the (NFSv4) change attribute can be used to detect remote mutations
>>> to a file's content or metadata, so that the appraisal could be cached
>>> as long as that attribute does not change. At least for NFSv4, clients
>>> assume their data cache is valid while the change attribute remains the
>>> same.
>>> 
>>> NFSv4 (and SMB) also has a mechanism where a server guarantees it will
>>> report any other clients that want to update a file. This is an NFSv4
>>> read delegation or an SMB oplock. NFSv4 clients use this mechanism to
>>> cache file data quite aggressively, and it could also be used to
>>> preserve or cache audit state on remote files.
>> 
>> The file data invalid message, plus trusting the server, is what
>> would be needed for reliably caching the validity of the file.
>
> What establishes client trust in the server? I'm probably missing
> something.

In this case I mean trust as in the believe that the server is not
actively trying to subvert the guarantees that IMA is depending upon.

One such guarantee is that if data is dropped from the page cache and
reread it will be the same data (unless the server let's you know).
AKA IMA needs to trust that the cache coherency protocol is implemented
honestly.

Except for the case of something like fusermount that is the standard
assumption today.  That the filesystem is not actively trying to trip
up the kernel.

> The NFS protocol can convey the contents of the file, it's attributes,
> and the contents of the security.ima and security.evm xattrs. The xattrs
> contain cryptographically signed integrity metadata, which I presume
> cannot be altered undetectably either at rest or in transit. The client
> has everything it needs to measure that file, doesn't it, as long as it
> has the correct set of keys to verify the signatures?
>
> Likely I am naive, but it seems to me a file server does not have to
> participate in this process, other than to store and return IMA xattrs
> along with the file content. All participating clients would need to
> carry the same set of keys, however.
>
> Please tell me if I'm hijacking the thread.

Unless something brings us to non-consensus about the patches to merge
we are good.  I think this is an area that need some discussion.

The big big thing right now, as I understand it, is these mechanisms that
nfs uses to keep the cache in sync are not clearly reflected in the vfs
in a way that ima can take advantage of them.


Please note I am stretching what we can do with the vfs in the kernel,
but working on unprivileged fuse mounts.  This has me asking all are
our kernel mechanisms ok if the server is actively hostile.  What
happens if the server on the first read returns an innocuous file that
matches it's ima xattr, but on the next read of the file returns an evil
trojan horse.  Or what if the server implements a cache coherency
protocol but lies and does not report all of the changes to a file.

Which is what got this conversation started in the first place
discovering that unprivileged fuse+xattrs is not something people have
looked at closely.

A side effect of the conversation is realizing that remote filesystems
have many of the same issues, but we can trust that the remote
filesystems are not actively hostile.  They just happen to not maintain
all of the same invariants as local filesystems (like all modifications
go through the local kernel).  Which leads to the implication that we
need some of these mechanisms on filesystems like nfs as well.

>>>> There's some very initial discussions on how to support file integrity
>>>> on remote filesystems.  Chuck Lever has some thoughts on piggy-backing 
>>>> on the fs-verity work being done.  From a very, very high level, IMA-
>>>> appraisal would verify the file signature, but leave the integrity
>>>> enforcement to the vfs/fs layer.  By integrating fs-verity or similar
>>>> proposal with IMA, measurements would be included in the measurement
>>>> list and keys used for file signature verification would use the same
>>>> existing IMA-appraisal infrastructure.
>>> 
>>>>> Mimi I believe you said that the requirement is that all file changes
>>>>> can be detected through the final __fput of a file that calls
>>>>> ima_file_free.
>>>> 
>>>> Right, like for fuse, I don't believe this existing hook works for
>>>> remote filesystems.
>> 
>> I am trying to understand things.
>> 
>> - I believe the beginning of any file write should invalidate the
>>  validity of the files cache.  IMA does something like that by looking
>>  at i_writecount.
>> 
>> - As I read the code ima_file_free triggers an update of the ima xattr
>>  and that update needs to wait until the file is quiescent.  AKA no
>>  more writers.  I am not certain how you get that in a remote
>>  filesystem.
>
> With NFSv4, a read delegation is sufficient to guarantee that the
> client is the only writer. The mechanism varies (or can be absent)
> for other remote filesystem protocols. And, an NFSv4 server is not
> obligated to always provide a delegation.
>
> An NFSv4 client can also OPEN a file with share deny modes. That
> would prevent other clients from accessing the file while the IMA
> metadata was recomputed. Again, I believe something similar would
> work for SMB3, but might not be applicable to other remote file-
> system protocols (eg NFSv3 does not have all this magic).
>
> However, computing a fresh IMA xattr would require access to the
> whole file. For a large file, a client would have to read it from
> the file server in its entirety, unless the file server offloads
> this computation from the client somehow. The server would need to
> wait until that client had CLOSEd the file to ensure that the
> client had no more cached dirty data, and at that point the server
> can itself guarantee there are no other remote accessors.

Which sounds to me like all of this is implementable if desired,
but that ima is not currently tied into these mechanisms.  Which
I expect is the next step.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
