From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 22 Mar 2018 15:44:15 -0400
Subject: [PATCH] ima: Add smackfs to the default appraise/measure list
In-Reply-To: <8d00361b-92ef-1fc6-fb2c-2316666dfbd3@schaufler-ca.com>
References: <1521726361-29916-1-git-send-email-mtownsend1973@gmail.com>
	<8d00361b-92ef-1fc6-fb2c-2316666dfbd3@schaufler-ca.com>
Message-ID: <1521747855.3848.274.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-03-22 at 12:05 -0700, Casey Schaufler wrote:
> On 3/22/2018 6:46 AM, Martin Townsend wrote:
> > This is required to use SMACK and IMA/EVM together. Add it to the
> > default nomeasure/noappraise list like other pseudo filesystems.
> >
> > Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks!

Mimi
> 
> > ---
> >  security/integrity/ima/ima_policy.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 915f557..d89ed15 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -96,6 +96,7 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
> >  	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
> > +	{.action = DONT_MEASURE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = CGROUP_SUPER_MAGIC,
> >  	 .flags = IMA_FSMAGIC},
> >  	{.action = DONT_MEASURE, .fsmagic = CGROUP2_SUPER_MAGIC,
> > @@ -141,6 +142,7 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
> >  	{.action = DONT_APPRAISE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
> > +	{.action = DONT_APPRAISE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
> >  	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
