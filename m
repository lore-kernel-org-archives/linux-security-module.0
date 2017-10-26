From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 26 Oct 2017 16:53:04 -0400
Subject: [PATCH v5 00/18] Appended signatures support for IMA appraisal
In-Reply-To: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
References: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
Message-ID: <1509051184.5886.139.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-10-17 at 22:53 -0200, Thiago Jung Bauermann wrote:
> Hello,
> 
> The main highlight in this version is that it fixes a bug where the modsig
> wasn't being included in the measurement list if the appraised file was
> already measured by another rule. The fix is in the last patch.
> 
> Another change is that the last patch in the v4 series ("ima: Support
> module-style appended signatures for appraisal") has been broken up into
> smaller patches. I may have overdone it...
> 
> Finally, I have added some patches removing superfluous parentheses from
> expressions. IMO these patches make it easier (and more pleasant) to read
> the code, and thus easier to understand it. Since I'm not sure how welcome
> the changes are, I split them in 3 "levels" in increasing potential for
> conflict with patches from other people (they can be squashed together when
> applied):
> 
> 1. patch 2 contains the bare minimum, changing only lines that are also
>    touched by other patches in the series;
> 
> 2. patch 3 cleans up all the files that are touched by this patch series;
> 
> 3. patch 4 cleans up all other EVM and IMA files that weren't already fixed
>    by the previous patches.
> 
> If unwanted, patches 3 and 4 can be simply skipped without affecting the
> rest of the patches. I have already rebased them from v4.13-rc2 to
> v4.14-rc3 and now to linux-integrity/next with very few easy to resolve
> conflicts, so I think they are worth keeping.
> 
> These patches apply on top of today's linux-integrity/next.

This cover letter and the patch descriptions are well written,
explaining what and why you're making this change. ?The problem is
that I don't agree that fewer parentheses makes the code more
readable. ?When you repost the patches (for other reasons), please
don't include these changes.

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
