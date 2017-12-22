From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 22 Dec 2017 12:01:24 -0800
Subject: Differentiating audit rules in an LSM stack
Message-ID: <a1f773ca-924d-1428-c8b3-0bf77f6cf796@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The audit rule field types AUDIT_SUBJ_* and AUDIT_OBJ_* are
defined generically and used by both SELinux and Smack to identify
fields that are interesting to them. If SELinux and Smack are running
concurrently both modules will identify audit rules as theirs if
either has requested the field. Before I go off and create a clever
solution I think it wise to ask if anyone has thought about or has
strong opinions on how best to address this unfortunate situation.

We know that SELinux and Smack together is not an especially
interesting configuration. It is, however, a grand test case for
generality of the solution. Any module that wanted to audit fields
that are defined generically will have this sort of problem.

Thanks

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
