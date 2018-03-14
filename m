From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 14 Mar 2018 14:46:41 -0500
Subject: [PATCH v3 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <279C5F8D-9A75-44C7-8287-023F634BB3A0@oracle.com> (Chuck Lever's
	message of "Wed, 14 Mar 2018 14:08:50 -0400")
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
	<CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
	<1521032461.3547.404.camel@linux.vnet.ibm.com>
	<877eqer5r6.fsf@xmission.com>
	<1521049841.3547.500.camel@linux.vnet.ibm.com>
	<279C5F8D-9A75-44C7-8287-023F634BB3A0@oracle.com>
Message-ID: <87in9yo2xq.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Chuck Lever <chuck.lever@oracle.com> writes:

>> On Mar 14, 2018, at 1:50 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> 
>> On Wed, 2018-03-14 at 11:17 -0500, Eric W. Biederman wrote:
>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>> 
>>>> On Wed, 2018-03-14 at 08:52 +0100, Stef Bon wrote:
>>>>> I do not have any comments about the patches but a question.
>>>>> I completely agree that the files can change without the VFS knowing
>>>>> about it, but isn't that in general the case with filesystems with a
>>>>> backend shared with others (network fs's?).
>>>> 
>>>> Right, the problem is not limited to fuse, but needs to be addressed
>>>> before unprivileged fuse mounts are upstreamed.
>>>> 
>>>> Alban's response to this question:
>>>> https://marc.info/?l=linux-kernel&m=151784020321045&w=2
>>> 
>>> Which goes to why it is a flag that get's set.
>>> 
>>> All of this just needs a follow-up patch to update every filesystem
>>> that does not meet ima's requirements.
>> 
>> Currently files on remote filesystems are measured/appraised/audited
>> once.  With the new flags, our options would be to either fail the
>> signature verification or constantly re-measure/re-appraise files on
>> remote file systems.  Neither option seems like the right solution.

They are measured/appraised/audited once, and you can not trust that at
all because you don't know when the files are going to be different.

So either keeping the filesystem out of the ima game or failing sounds
like the right answer to me.  At least until you can get better
information from the filesystem.

> Being new to this game, I may be making a bad assumption, but I thought
> that the (NFSv4) change attribute can be used to detect remote mutations
> to a file's content or metadata, so that the appraisal could be cached
> as long as that attribute does not change. At least for NFSv4, clients
> assume their data cache is valid while the change attribute remains the
> same.
>
> NFSv4 (and SMB) also has a mechanism where a server guarantees it will
> report any other clients that want to update a file. This is an NFSv4
> read delegation or an SMB oplock. NFSv4 clients use this mechanism to
> cache file data quite aggressively, and it could also be used to
> preserve or cache audit state on remote files.

The file data invalid message, plus trusting the server, is what
would be needed for reliably caching the validity of the file.

>> There's some very initial discussions on how to support file integrity
>> on remote filesystems.  Chuck Lever has some thoughts on piggy-backing 
>> on the fs-verity work being done.  From a very, very high level, IMA-
>> appraisal would verify the file signature, but leave the integrity
>> enforcement to the vfs/fs layer.  By integrating fs-verity or similar
>> proposal with IMA, measurements would be included in the measurement
>> list and keys used for file signature verification would use the same
>> existing IMA-appraisal infrastructure.
>
>>> Mimi I believe you said that the requirement is that all file changes
>>> can be detected through the final __fput of a file that calls
>>> ima_file_free.
>> 
>> Right, like for fuse, I don't believe this existing hook works for
>> remote filesystems.

I am trying to understand things.

- I believe the beginning of any file write should invalidate the
  validity of the files cache.  IMA does something like that by looking
  at i_writecount.

- As I read the code ima_file_free triggers an update of the ima xattr
  and that update needs to wait until the file is quiescent.  AKA no
  more writers.  I am not certain how you get that in a remote
  filesystem.

  If the write is not coming from the local kernel I don't see how it
  makes any sense for IMA to actually update the xattr on write.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
