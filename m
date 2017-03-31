From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Fri, 31 Mar 2017 09:52:54 +0900
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <c0e1918a-a483-23b7-2bef-871082f80e10@schaufler-ca.com>
References: <1490698960-29861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<0dbdca69-ae69-a07e-957a-246d3e7532f2@schaufler-ca.com>
	<201703302009.HFI48472.MOFJOQStHFVOLF@I-love.SAKURA.ne.jp>
	<c0e1918a-a483-23b7-2bef-871082f80e10@schaufler-ca.com>
Message-ID: <201703310952.GED78634.OFQMFVtHSOJOLF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> On 3/30/2017 4:09 AM, Tetsuo Handa wrote:
> > Even though TOMOYO uses per "struct task_struct" blob, TOMOYO can
> > start running with any other LSM modules by applying below change.
> > What are you worrying about?
> 
> Until such time as a blob sharing scheme, either the one
> I've been working on, yours below or something else, is
> adopted, and until another module starts using the task
> blob, you could use TOMOYO with any other module. The
> existing model for choosing a "major" module does not
> allow for TOMOYO+AppArmor. Ignoring the blob management
> issue, how would you suggest enabling TOMOYO+AppArmor? 

Changing

-#define SECURITY_NAME_MAX       10
+#define SECURITY_NAME_MAX       64

 int __init security_module_enable(const char *module)
 {
-	return !strcmp(module, chosen_lsm);
+	return strstr(chosen_lsm, module) != NULL;
 }

and passing

  security=tomoyo,apparmor

to the kernel boot command line option, with checking for currently conflicting
choices like an example below.

	pr_info("Security Framework initialized\n");
+	if (IS_ENABLED(CONFIG_SECURITY_SELINUX) && IS_ENABLED(CONFIG_SECURITY_SMACK) && security_module_enable("selinux") && security_module_enable("smack"))
+		panic("Selected combination is not supported\n");

> 
> > If we want per LSM module per "struct task_struct" blob before
> > TOMOYO is converted to use per "struct task_struct" blob, I'm ready to
> > propose that part (picked up from below change) first.
> 
> I suggest that the best thing to do regarding the task blob
> is to adopt a general blob sharing scheme that is useful for
> all of the blobs rather than inventing a special one for TOMOYO.
> 

Since we are already receiving proposals of new modules which want to
use the task blob, I think priority of sharing (isolating ?) the task
blob (in other words, allow multiple modules to call task_alloc/task_free
hooks) is higher than enabling SELinux+Smack.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
