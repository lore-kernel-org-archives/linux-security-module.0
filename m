From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 11 Sep 2018 09:52:59 -0400
Subject: Overlayfs @ Containers and checkpoint/restart micro-conference
	at LPC2018
In-Reply-To: <20180909091549.yekfuds633afhrgw@mailbox.org>
References: <CAOQ4uxih7rPPLquJZFL9HtSbUFi-cCOR21qH4_-ORxxLKGsLXg@mail.gmail.com>
	<20180909091549.yekfuds633afhrgw@mailbox.org>
Message-ID: <20180911135259.GB27845@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 09, 2018 at 11:18:54AM +0200, Christian Brauner wrote:
[..]
> My team hast just started to be more involved with shifts development a
> few months back. Overlayfs is definitely an inspiration and we even once
> thought about making shifts an extension of overlayfs.
> Seth Forshee on my team is currently actively working on shifts and
> getting a POC ready.
> When he has a POC based on James' patchset there will be an RFC that
> will go to fsdevel and all parties of interest.
> There will also be an update on shifts development during the microconf.
> So even more reason for developers from overlayfs to stop by.

So we need both shiftfs and overlayfs in container deployments, right?
shiftfs to make sure each container can run in its own user namespace
and uid/gid mappings can be setup on the fly and overlayfs to provide
union of multiple layers and copy on write filesystem. I am assuming that
shiftfs is working on top of overlayfs here?

Doing shifting at VFS level using mount API was another idea discussed
at last plumbers. I saw David Howells was pushing all the new mount
API patches. Not sure if he ever got time to pursue shifting at VFS
level.

BTW, now we have metadata only copy up patches in overlayfs as
well(4.19-rc). That speeds up chown operation with overlayfs,
needed for changing ownership of files in images for making sure
they work fine with user namespaces. In my simple testing in a VM,
a fedora image was taking around 30 seconds to chown. With metadata
only copy up that time drops to around 2-3 seconds. So till shiftfs
or shiting at VFS level gets merged, it can be used as a stop gap
solution.

Thanks
Vivek
