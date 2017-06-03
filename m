From: matt@nmatt.com (Matt Brown)
Date: Sat, 3 Jun 2017 18:30:08 -0400
Subject: [kernel-hardening] [PATCH v1 1/1] Add Trusted Path Execution as a
	stackable LSM
In-Reply-To: <CAG48ez1W6Pwxuhc92OGvtmLQLE8XhXCJvZDoqDCMSODvtGUT_A@mail.gmail.com>
References: <20170603055351.16080-1-matt@nmatt.com>
	<CAG48ez1W6Pwxuhc92OGvtmLQLE8XhXCJvZDoqDCMSODvtGUT_A@mail.gmail.com>
Message-ID: <1186cd9b-f689-2ea5-f5d2-62893ce7489f@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/03/2017 06:39 AM, Jann Horn wrote:
> On Sat, Jun 3, 2017 at 7:53 AM, Matt Brown <matt@nmatt.com> wrote:
>> This patch was modified from Brad Spengler's Trusted Path Execution (TPE)
>> feature in Grsecurity and also incorporates logging ideas from
>> cormander's tpe-lkm.
>>
>> Modifications from the Grsecurity implementation of TPE were made to
>> turn it into a stackable LSM using the existing LSM hook bprm_set_creds.
>> Also, denial messages were improved by including the full path of the
>> disallowed program. (This idea was taken from cormander's tpe-lkm)
> [...]
>> Threat Models:
> [...]
>> 2. Attacker on system replaces binary used by a privileged user with a
>>    malicious one
>>
>> *  This situation arises when administrator of a system leaves a binary
>>    as world writable.
>>
>> *  TPE is very effective against this threat model
>
> How do you end up with world-writable binaries in $PATH?
>

Sys Admin screw up. It also protects against world-writable binaries
anywhere on the system, not just in $PATH.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
