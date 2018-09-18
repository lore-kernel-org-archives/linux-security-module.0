From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 18 Sep 2018 08:23:11 -0700
Subject: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
	Landlock
In-Reply-To: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<alpine.LRH.2.21.1809130727310.19741@namei.org>
	<d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Message-ID: <6c678308-fae3-22b0-8750-20d1b70e1bc5@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/18/2018 12:44 AM, Micka?l Sala?n wrote:
> On 9/12/18 23:29, James Morris wrote:
>> Adding the SARA and LandLock authors for review & comment.
>>
>> Salvatore & Micka?l: does this patchset meet your needs for merging to 
>> mainline?
> It almost does! For now, I need the task_struct, cred, inode and file
> security blobs. Only the task_struct one is missing.

I will add the task blob as well as the ipc blob needed by
SARA for v3.
?

>
> FYI, the capitalization of Landlock is not consistent in all commit
> messages. :)

Sorry. I have been trying to get people to use Smack instead
of SMACK for years. I will strive to use Landlock consistently.
