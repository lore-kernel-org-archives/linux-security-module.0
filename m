From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 15 Mar 2018 10:33:12 -0700
Subject: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
	<20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
	<87vadxfwqj.fsf@xmission.com>
	<c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
Message-ID: <1521135192.5348.64.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-03-15 at 11:26 -0400, Stefan Berger wrote:
> On 03/15/2018 06:40 AM, Eric W. Biederman wrote:
> > 
> > Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
> > 
> > > 
> > > From: Yuqiong Sun <suny@us.ibm.com>
> > > 
> > > Add new CONFIG_IMA_NS config option.??Let clone() create a new
> > > IMA namespace upon CLONE_NEWNS flag. Add ima_ns data structure in
> > > nsproxy. ?ima_ns is allocated and freed upon IMA namespace
> > > creation and exit. ?Currently, the ima_ns contains no useful IMA
> > > data but only a dummy interface. This patch creates the framework
> > > for namespacing the different aspects of IMA (eg. IMA-audit, IMA-
> > > measurement, IMA-appraisal).
> > IMA is not path based.??The only thing that belongs to a mount
> > namespace are paths.??Therefore IMA is completely inappropriate to
> > be joint with a mount namespace.

Just to be clear: The mount namespace is not only about paths it's also
about subtree properties. ?However, the point still stands that IMA has
a dependency on neither.

> IMA measures the files described by these paths. The files also may
> hold signatures (security.ima xattr) needed for IMA appraisal.

The xattr is an inode property, which isn't namespaced by the mount_ns.

When we had this discussion last year, we talked about possibly using
the user_ns instead. ?It makes sense because for IMA signatures you're
going to need some type of keyring namespace and there's already one
hanging off the user_ns:

commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
Author: David Howells <dhowells@redhat.com>
Date:???Tue Sep 24 10:35:19 2013 +0100

????KEYS: Add per-user_namespace registers for persistent per-UID
kerberos caches

> > I saw that Serge even recently mentioned that you need to take
> > this aspect of the changes back to the drawing board.??With my
> > namespace maintainer hat on I repeat that.
> 
> Drawing board is here now (tuning on the text...):
> 
> http://kernsec.org/wiki/index.php/IMA_Namespacing_design_consideratio
> ns

You mention an abuse case here which is basically a way of relaxing
security policy. ?Cannot we fix that by making policy hierarchical, so
a child namespace must have the same or a more strict policy than the
parent?

> > ?From a 10,000 foot view I can already tell that this is hopeless.
> > So for binding IMA namspaces and CLONE_NEWNS:
> > 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > I am not nacking IMA namespacing just inappropriately tying ima
> > namespaces to mount namespaces.??These should be completely
> > separate entities.
> 
> Let's say we go down the road of spawning it independently. Can we
> use the unused clone flag 0x1000? Or should we come up with new?
> unshare2()/clone2() syscalls to extend the clone bits to 64 bit? Or
> use a sysfs/securityfs file to spawn a new IMA namespace? Make this a
> generic file not an IMA specific one?

If, as a result of discussions, it turns out that a separate namespace
is the correct way to proceed, I'm sure we can sort out the details of
how we cope with the flag paucity problem.

James


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
