From: jannh@google.com (Jann Horn)
Date: Thu, 6 Sep 2018 20:22:35 +0200
Subject: Smack: wrong-looking capable() check in smk_ptrace_rule_check()
Message-ID: <CAG48ez0nCC0_on95q7x_8cwSyJ8ATReA0ysDnEr=CW2tkqE=7w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi!

I noticed the following check in smk_ptrace_rule_check():

                if (tracer_known->smk_known == tracee_known->smk_known)
                        rc = 0;
                else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
                        rc = -EACCES;
                else if (capable(CAP_SYS_PTRACE))
                        rc = 0;
                else
                        rc = -EACCES;

Note that smk_ptrace_rule_check() can be called from not just
smack_ptrace_access_check() and smack_ptrace_traceme(), but also
smack_bprm_set_creds(). AFAICS this means that if a task executes with
a smack privilege transition and smack_ptrace_rule is
SMACK_PTRACE_EXACT, whether the execution is permitted depends on
whether _the debugged task_ has CAP_SYS_PTRACE (and not on whether the
debugger has that capability).
This seems like it's probably unintentional?
