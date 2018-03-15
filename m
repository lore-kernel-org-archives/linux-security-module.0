From: stefbon@gmail.com (Stef Bon)
Date: Thu, 15 Mar 2018 11:07:44 +0100
Subject: [PATCH v3 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <87a7vamizo.fsf@xmission.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
	<CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
	<1521032461.3547.404.camel@linux.vnet.ibm.com>
	<877eqer5r6.fsf@xmission.com>
	<1521049841.3547.500.camel@linux.vnet.ibm.com>
	<279C5F8D-9A75-44C7-8287-023F634BB3A0@oracle.com>
	<87in9yo2xq.fsf@xmission.com>
	<874F0391-1E88-498E-970B-78674057028D@oracle.com>
	<87a7vamizo.fsf@xmission.com>
Message-ID: <CANXojcykVCExV9Hops4Py8mGvS=g1u=oLV4BNyM04iW+asQUpA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2018-03-14 22:42 GMT+01:00 Eric W. Biederman <ebiederm@xmission.com>:
>>
>> Please tell me if I'm hijacking the thread.
>
> Unless something brings us to non-consensus about the patches to merge
> we are good.  I think this is an area that need some discussion.
>
> The big big thing right now, as I understand it, is these mechanisms that
> nfs uses to keep the cache in sync are not clearly reflected in the vfs
> in a way that ima can take advantage of them.
>
>

Chuck you mean fschange notifications methods like
NT_TRANSACT_NOTIFY_CHANGE for cifs. I believe that NFS4 has something simular.
These mechanism will inform the client when a file in a watched
directory is changed.
This is not yet supported in Linux (these methods are not triggered
any way when setting a watch using inotify for exmple).
There was support with dnotify
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cifs/cifssmb.c#n6393).

But these methods are triggered by the user and not the VFS/kernel and
therefore cannot garantee that all files on the client
are the same as on the server.
This also counts for a read delegation with nfs and methods like
leases in a client server environment.

Stef
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
