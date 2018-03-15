From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 15 Mar 2018 11:45:35 -0700
Subject: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
	<20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
	<87vadxfwqj.fsf@xmission.com>
	<c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
	<1521135192.5348.64.camel@HansenPartnership.com>
	<2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
Message-ID: <1521139535.5348.89.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-03-15 at 14:26 -0400, Stefan Berger wrote:
> On 03/15/2018 01:33 PM, James Bottomley wrote:
> > 
> > On Thu, 2018-03-15 at 11:26 -0400, Stefan Berger wrote:
[...]
> > > 
> > > IMA measures the files described by these paths. The files also
> > > may hold signatures (security.ima xattr) needed for IMA
> > > appraisal.
> > The xattr is an inode property, which isn't namespaced by the
> > mount_ns.
> > 
> > When we had this discussion last year, we talked about possibly
> > using the user_ns instead.??It makes sense because for IMA
> > signatures you're
> 
> 'using the user_ns' I suppose means hooking IMA namespace to it...

Yes, making it belong to the user ns instead of the mnt ns.

I'm not saying it has to, but I equally don't see a good reason IMA has
to have its own namespace, especially as the keyrings are tied to the
user_ns.

> > going to need some type of keyring namespace and there's already
> > one hanging off the user_ns:
> > 
> > commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
> > Author: David Howells <dhowells@redhat.com>
> > Date:???Tue Sep 24 10:35:19 2013 +0100
> > 
> > ?????KEYS: Add per-user_namespace registers for persistent per-UID
> > kerberos caches
> 
> The benefit for IMA would be that this would then tie the keys needed
> for appraising to the IMA namespace's policy.
> However, if you have an appraise policy in your IMA namespace, which
> is now hooked to the user namespace, and you join that user namespace
> but your files don't have signatures, nothing will execute anymore.
> That's now a side effect of joining this user namespace unless we
> have a magic ?exception. My feeling is, people may not like that...

Agree, but I think the magic might be to populate the ima keyring with
the parent on user_ns creation. ?That way the user_ns owner can delete
the parent keys if they don't like them, but by default the parent
appraisal policy should just work.

> > > > I saw that Serge even recently mentioned that you need to take
> > > > this aspect of the changes back to the drawing board.??With my
> > > > namespace maintainer hat on I repeat that.
> > > Drawing board is here now (tuning on the text...):
> > > 
> > > http://kernsec.org/wiki/index.php/IMA_Namespacing_design_consider
> > > ations
> > You mention an abuse case here which is basically a way of relaxing
> > security policy.??Cannot we fix that by making policy hierarchical,
> > so a child namespace must have the same or a more strict policy
> > than the parent?
> 
> I updated the page now with a hopefully better idea. So that root
> cannot escape IMA-appraisal by spawning IMA namespaces and setting an
> IMA NULL policy, root's activities will *always* be evaluated against
> the init_ima_ns policy with keys found in the init_user_ns. In other
> word, if there is an appraisal policy (rule) on the host's
> init_ima_ns and root does something as uid 0 in any namespace, file
> activity for appraising purposes must pass signature checking. So
> just spawning a MNT namespace, mounting a filesystem with unknown
> apps won't execute any of them unless the stuff is signed.

So this would mean that most orchestration systems' ideas of privileged
containers (i.e. containers which run real root) would be unable to
have their own IMA namespace ... that's also going to be surprising.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
