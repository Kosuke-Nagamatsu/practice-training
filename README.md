# README

* Table schema

**User**
| column | data type |
| ---- | ---- |
| id | primary_key |
| email | string |
| password_digest | string |

**Task**
| column | data type |
| ---- | ---- |
| id | primary_key |
| user_id(FK) | bigint |
| tittle | string |
| content | text |
| time_limit | datetime |
| priority | string |
| status | string |

**Label**
| column | data type |
| ---- | ---- |
| id | primary_key |
| task_id(FK) | bigint |
| content | string |

**TaskLabel**
| column | data type |
| ---- | ---- |
| id | primary_key |
| task_id(FK) | bigint |
| label_id(FK) | bigint |
