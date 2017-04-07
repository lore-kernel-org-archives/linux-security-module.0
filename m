From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 07 Apr 2017 08:36:17 -0400
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <27362.1491556638@warthog.procyon.org.uk>
References: <1491551180.4184.50.camel@linux.vnet.ibm.com>
	<1491536950.4184.10.camel@linux.vnet.ibm.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
	<21572.1491548994@warthog.procyon.org.uk>
	<27362.1491556638@warthog.procyon.org.uk>
Message-ID: <1491568577.4184.97.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-04-07 at 10:17 +0100, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > > Okay, fair enough.  I can stick in an OR with an IS_ENABLED on some IMA
> > > symbol.  CONFIG_IMA_KEXEC maybe?  And also require IMA be enabled?
> > 
> > Not quite, since as Dave pointed out, IMA is policy driven.  As a
> > policy is installed, we could set a flag.
> 
> Does such a flag exist as yet?

Not exactly what is needed. ?There's a flag named ima_appraise, which
is used internally in IMA. A temporary flag is created, while
validating the rules.

	if (default_appraise_rules[i].func == POLICY_CHECK)
        	temp_ima_appraise |= IMA_APPRAISE_POLICY;

        if (!result && (entry->action == UNKNOWN))
                result = -EINVAL;
        else if (entry->func == MODULE_CHECK)
                temp_ima_appraise |= IMA_APPRAISE_MODULES;
        else if (entry->func == FIRMWARE_CHECK)
                temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
        else if (entry->func == POLICY_CHECK)
                temp_ima_appraise |= IMA_APPRAISE_POLICY;

If the entire policy is valid,   ima_update_policy_flag() sets the ima_appraise flag.

        ima_appraise |= temp_ima_appraise;

>From an IMA perspective, either a file hash or signature are valid,
but for this usage it must be a signature. ?So in addition to testing
entry->func, above, entry->flags would need to be tested as well to
detect if IMA_DIGSIG_REQUIRED is set.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
