From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 14 Jul 2017 15:26:14 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <xagsmtp2.20170714182525.6604@vmsdvm4.vnet.ibm.com>
References: <87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<20170714133437.GA16737@mail.hallyn.com>
	<596f808b-e21d-8296-5fef-23c1ce7ab778@linux.vnet.ibm.com>
	<20170714173556.GA19669@mail.hallyn.com>
	<xagsmtp2.20170714182525.6604@vmsdvm4.vnet.ibm.com>
Message-ID: <1500060374.3583.57.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-07-14 at 13:17 -0500, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serge@hallyn.com> writes:
> 
> > Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> >> On 07/14/2017 09:34 AM, Serge E. Hallyn wrote:
> >> >Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> >> >>On 07/13/2017 08:38 PM, Eric W. Biederman wrote:
> >> >>>Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
> >> >>>
> >> >>>>On 07/13/2017 01:49 PM, Eric W. Biederman wrote:
> >> >>>>
> >> >>>>>My big question right now is can you implement Ted's suggested
> >> >>>>>restriction.  Only one security.foo or secuirty.foo at ... attribute ?
> >> >>>>We need to raw-list the xattrs and do the check before writing them. I am fairly sure this can be done.
> >> >>>>
> >> >>>>So now you want to allow security.foo and one security.foo at uid=<> or just a single one security.foo(@[[:print:]]*)?
> >> >>>>
> >> >>>The latter.
> >> >>That case would prevent a container user from overriding the xattr
> >> >>on the host. Is that what we want? For limiting the number of xattrs
> >> >Not really.  If the file is owned by a uid mapped into the container,
> >> >then the container root can chown the file which will clear the file
> >> >capability, after which he can set a new one.  If the file is not
> >> >owned by a uid mapped into the container, then container root could
> >> >not set a filecap anyway.
> >> 
> >> Let's say I installed a container where all files are signed and
> >> thus have security.ima. Now for some reason I want to re-sign some
> >> or all files inside that container. How would I do that ? Would I
> >> need to get rid of security.ima first, possibly by copying each
> >> file, deleting the original file, and renaming the copied file to
> >> the original name, or should I just be able to write out a new
> >> signature, thus creating security.ima at uid=1000 besides the
> >> security.ima ?
> >> 
> >>    Stefan
> >
> > Hi Mimi,
> >
> > what do you think makes most sense for IMA?
> 
> I am going to give my two cents since I have been thinking about this.
> 
> First I think this entire scheme plays hobs with the security.evm
> attribute as security.evm needs to know the names of the xattrs to
> protect.
> 
> I forget which attributes has a hash and what has a message
> athentication code.

security.ima contains either a file hash or a signature.  (file data)
security.evm contains either a signature or an hmac of the security
xattrs and other file metadata. (file meta-data)

The same rules would apply to security.evm, as described in my
response. ?Based on it's view of the security xattrs, either the
native or namespace security.evm would be updated.

> If there is an attribute with a simple file hash I think it only make
> sense for the kernel to touch it, and I don't see any sense in having
> multiples.

Only files that are in the IMA-appraisal policy is the file hash
calculated and written out as security.ima. ?Depending this policy,
does the security.ima exist. ?So if the file is in policy for both the
native and namespace policies, agreed the same hash doesn't need to be
written as two different xattrs.

> If there is an attribute with a message authentication code (roughly a
> signed hash) it makes sense to have that to be tied to the kernel key
> ring that controlls the keys.  (Which probably means a per user
> namespace thing at some point).  But again pretty untouchable otherwise.

Right, the namespace would require it's own EVM key. 

> Which brings us to the semantic question of would it be nice to have
> stacked IMA/EVM on the same file.
> 
> I really don't think we do.  I think allowing multiple keys for
> different part of trusting files is easy enough that we should have no
> need to fight over which keys do which.

We definitely want to support different policies on the native and in
the namespace with different keys and keyrings.

Refer to Mehmet Kaaylap's recent post, which refers to a PoC version
of IMA namespacing - kernsec.org/pipermail/linux-security-module-
archive/2017-July/002286.html.

> Looking at integrity.h I see signature_v2_hdr that has a keyid.  Any use
> case I can think of for distributing a distribution image with ima/evm
> xattrs will need to use asymmetric keys aka public/private keypairs so
> that the originator of the content does not give away their private
> keys.

Agreed.

> Given that usefully we are talking about content that should be
> connected to keys in one way or another I don't believe it even makes
> sense at this point to attempt to use uids for dealing with ima and
> evm content.

We need to resolve the xattr issue in order to namespace IMA-
appraisal.?

Mimi

> Further looking Serge's previous patch is 300 lines of code Setfan's
> patch that provides the possibility of code resuse is 500 lines of code.
> 
> Increasingly it is looking to me that code reuse rather than concept
> reuse is a false economy.  The code does not get smaller.  The semantic
> differences make it problematic.  Possibly to the problematic to the
> point where significant pieces may not be reused.  The format breaks
> assumptions for other parts of the code like security.evm.  The format
> by multiple names instead of a single attribute requires more disk
> access so is less efficient.
> 
> In short I am seeing more code that runs slower and is harder to
> maintain.  Please point out where I am wrong.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
