From: serge@hallyn.com (Serge E. Hallyn)
Date: Sun, 1 Apr 2018 15:08:27 -0500
Subject: [RFC v3 0/2] WhiteEgret LSM module
In-Reply-To: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
Message-ID: <20180401200827.GA28101@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Masanobu Koike (masanobu2.koike at toshiba.co.jp):
...
> Assumptions and ToDos
> 
> At this stage, WhiteEgret assumes the following.
> Relaxing these assumptions are future works.
> - Root is not compromised. And using a whitelist and a WEUA
> requires root privilege.
> - WEUA is reliable.
> - It is allowed for scripting languages, e.g., Perl or Python,
> to read arbitrary scripts and to execute them.

Hi,

regardling the last one, do you have a plan for handling it?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
