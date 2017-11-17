From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 17 Nov 2017 07:21:26 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <ddad05d7-1e74-e7b4-d59c-f2e217aa92b5@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<1510061855.3425.113.camel@linux.vnet.ibm.com>
	<aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
	<CAGXu5jKjXqn-1j881vYc1F0POPhPJOPZB1w=W_zfgdXTsiyX6A@mail.gmail.com>
	<ddad05d7-1e74-e7b4-d59c-f2e217aa92b5@huawei.com>
Message-ID: <1510921286.5920.41.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-17 at 09:55 +0100, Roberto Sassu wrote:
> On 11/17/2017 2:08 AM, Kees Cook wrote:
> > On Tue, Nov 7, 2017 at 8:45 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >> On 11/7/2017 2:37 PM, Mimi Zohar wrote:
> >>> Normally, the protection of kernel memory is out of scope for IMA.
> >>> This patch set introduces an in kernel white list, which would be a
> >>> prime target for attackers looking for ways of by-passing IMA-
> >>> measurement, IMA-appraisal and IMA-audit.  Others might disagree, but
> >>> from my perspective, this risk is too high.
> > 
> > BTW, which part of the series does the whitelist? I'd agree generally,
> > though: we don't want to make things writable if they're normally
> > read-only.

The white list is a proposed new feature.

> Patch 5/15 introduces the hash table ima_digests_htable and the
> functions to add/search file digests
> 
> Patches 6-7-8/15 add file digests to ima_digests_htable
> 
> Patch 10/15 searches file digests in ima_digests_htable
> 
> 
> Original files containing digest lists are discarded after being parsed.
> 
> 
> >> It would be much easier for an attacker to just set ima_policy_flag to
> >> zero.
> > 
> > That's a fair point. I wonder if ima_policy_flag could be marked
> > __ro_after_init? Most of the writes are from __init sections, but I
> > haven't looked closely at when ima_update_policy() gets called.
> 
> Unfortunately not. New policies can be loaded by writing to a file in
> the securityfs filesystem. They could enable different actions
> (measurement/appraisal/audit).

The ima_policy_flag is an optimization indicating which actions -
MEASURE, APPRAISE, AUDIT - the policy contains. ?The IMA policy,
itself, can be replaced with a signed custom policy just once. ?This
is normally done in the initramfs, after the LSM policies have been
loaded, in order to define policy rules in terms of LSM labels. ?Once
the new policy is loaded, the ima_policy_flag is set.

A Kconfig option allows additional signed rules to be added to the IMA
policy. ?After adding these new rules, additional actions can be added
to the policy flag, but not cleared.

The system admin/owner knows, prior to loading the custom policy,
which actions will be defined. ?Instead of waiting for the policy to
be written, the ima_policy_flag could be set at init. ?(We could
extend the existing "ima_policy=" boot command line option.) ?If not
the ima_policy_flag, itself, then a shadow of the ima_policy_flag,
which is OR'ed with the ima_policy_flag.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
