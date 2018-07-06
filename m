From: tyhicks@canonical.com (Tyler Hicks)
Date: Fri,  6 Jul 2018 05:24:59 +0000
Subject: [PATCH 0/2] Fix AppArmor issues found through static analysis
Message-ID: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This set fixes three issues, discovered by CoverityScan, that I don't
believe are serious in practice but are worth fixing to make the
AppArmor code more robust and prevent them from becoming more serious
issues in the future. The first patch fixes possible out of bounds
access issues when mapping a permissions mask to a string. The second
fixes an uninitialized struct that could have some of its contents
leaked to userspace during a permissions query.

I've tested the patches with the AppArmor regression test suite. The
test results are the same with and without these patches applied. There
are identical failures, in both situations, from the aa_policy_cache
test but that's likely due to some unrelated, recent changes in the
AppArmor userspace code.

Tyler

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
